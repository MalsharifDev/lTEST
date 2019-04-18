//
//  NetworkManager.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import Foundation
import Alamofire
import Reachability


class NetworkManager {
    
    static let sharedInstance: NetworkManager = NetworkManager()
    private var manager: SessionManager?
    
    var reachability = Reachability()!
    var reachable = true
    
    init() {
        initializeManager()
        startReachability()
    }
    
    func initializeManager() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func startReachability() {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
                self.reachable = true
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                print("Not reachable")
                self.reachable = false
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func executeRequest(request : RequestBase, completionHandler:@escaping (_ apiResponse:Response, _ httpStatusCode: Int?)->Void) {
        
        if !reachable {
            completionHandler(Response(data: ["error"] , parser: request.parser(), nil), nil)
            return
        }
        
        var postType = HTTPMethod.get
        
        if request.requestType() == RequestType.POST {
            postType = HTTPMethod.post
        }
        var urlString = request.url()
        if let encoded_ = request.url().addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            urlString = encoded_
        }
        
        manager?.request(urlString, method: postType, parameters: request.parameters(), encoding: JSONEncoding.default, headers: request.authorizationHeader())
            
            .responseString { (response) in
                print("responseString = \(response)")
            }
            
            .responseJSON { (response) in
                let httpStatusCode = response.response?.statusCode
                
                if response.result.isSuccess {
                    
                    
                    let jsonString:AnyObject = response.result.value as AnyObject
                    let responseObj = Response(data: jsonString, parser: request.parser(), httpStatusCode)
                    completionHandler(responseObj, httpStatusCode)
                    
                    
                } else {
                    let error = response.error?.localizedDescription
                    if let error_ = error {
                        completionHandler(Response(error: error_), httpStatusCode)
                    } else {
                        completionHandler(Response(data: [ AnyObject](), parser: request.parser(), httpStatusCode), httpStatusCode)
                    }
                }
        }
    }
}

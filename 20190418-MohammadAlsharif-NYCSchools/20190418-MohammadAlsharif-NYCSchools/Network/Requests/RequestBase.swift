//
//  RequestBase.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import Foundation
import Alamofire

enum RequestType : Int {
    case GET
    case POST
}

class RequestBase {
    
    /// host server base url
    ///
    /// - Returns: string
    func hostUrl() -> String {
        return devServer()
    }
    
    /// authorization required
    ///
    /// - Returns: yes/no
    func isAuthRequired() -> Bool {
        return true
    }
    
    /// web service url
    ///
    /// - Returns: url
    func url() -> String {
//        print("Complete URL \(hostUrl() + endPoint())")
        
        return hostUrl() + endPoint()
    }
    
    /// end point
    ///
    /// - Returns: string
    func endPoint() -> String {
        return ""
    }
    
    /// Returned parameters can be used as body or query parameters
    ///
    /// - Returns: dictionary
    func parameters() -> [String : AnyObject]? {
        return nil
    }
    
    func parametersData() -> [String : Data]? {
        return nil
    }
    /// Request type
    ///
    /// - Returns: request type
    func requestType() -> RequestType {
        return .GET
    }
    
    /// Parser to parse respective request
    ///
    /// - Returns: Parser
    func parser() -> ParserBase {
        return ParserBase()
    }
    
    
    /// device token
    ///
    /// - Returns: string
    func deviceToken() -> String {
        return ""
    }
    
    
    /// authorization header
    ///
    /// - Returns: dictionary
    func authorizationHeader() -> [String: String]? {
        return nil
    }
}

//MARK:- Private
extension RequestBase {
    func devServer() -> String {
        return "https://data.cityofnewyork.us/resource"
    }
}

//
//  SchoolListService.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SchoolListService: ServiceBase {
    
    func fetchSchools(offset:String, limit:String, completionHandler: @escaping ((_ response : SchoolResponse?) -> (Void))) {
        
        let request = SchoolListRequest(offset:offset, limit:limit)
        networkManager.executeRequest(request: request, completionHandler: { (response, httpStatusCode) -> Void in
            
            if (response.status == .Success) {
                
                if response.data is SchoolResponse? {
                    self.networkManager.initializeManager()
                    completionHandler(response.data as? SchoolResponse)
                }
                else {
                    completionHandler(nil) // Unknown error, should not happen
                }
            }  else {
                
                if (response.data as? SchoolResponse) != nil {
                    completionHandler(response.data as? SchoolResponse) // Error in response from server
                } else {
                    completionHandler(nil) // Unknown error, should not happen
                }
            }
        })
    }
}

//
//  SATScoreService.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SATScoreService: ServiceBase {
    
    func fetchScore(school_id:String, completionHandler: @escaping ((_ response : SATScoreResponse?) -> (Void))) {
        
        let request = SATScoreRequest(schoolId: school_id)
        networkManager.executeRequest(request: request, completionHandler: { (response, httpStatusCode) -> Void in
            
            if (response.status == .Success) {
                
                if response.data is SATScoreResponse? {
                    self.networkManager.initializeManager()
                    completionHandler(response.data as? SATScoreResponse)
                }
                else {
                    completionHandler(nil) // Unknown error, should not happen
                }
            } else {
                
                if (response.data as? SATScoreResponse) != nil {
                    completionHandler(response.data as? SATScoreResponse) // Error in response from server
                } else {
                    completionHandler(nil) // Unknown error, should not happen
                }
            }
        })
    }
}

//
//  SchoolListParser.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SchoolListParser: ParserBase {
    
    override func parseData(data:  Any) -> AnyObject? {
        
        var response = SchoolResponse()
        
        let data = data as AnyObject
        response.success = data as? Array<Any> 
        response.error = data["error"] as? Bool ?? false
        response.message = data["message"] as? String ?? "Something went wrong please try again."

        return response as AnyObject?
    }
}
struct SchoolResponse {
    
    var success: Array<Any>?
    var error: Bool?
    var message: String?
    public init () {
    }
}

 

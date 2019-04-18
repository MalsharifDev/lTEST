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
       
        //parse school list
        let schoolList = data as! [[String: Any]]
        for schoolData in schoolList {
            var school = SchoolDetails()
            school.school_name = schoolData["school_name"] as? String
            school.school_id = schoolData["dbn"] as? String
            school.school_address = schoolData["primary_address_line_1"] as? String
            response.schoolList.append(school)
        }
        
        response.error = data["error"] as? Bool ?? false
        response.message = data["message"] as? String ?? "Something went wrong please try again."

        return response as AnyObject?
    }
}
struct SchoolResponse {
    
    var success: Array<Any>?
    var schoolList = [SchoolDetails]()
    var error: Bool?
    var message: String?
    public init () {
    }
}

struct SchoolDetails {
    var school_address: String?
    var school_id: String?
    var school_name: String?
    public init () {
    }
}

//
//  SchoolListRequest.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SchoolListRequest: RequestBase {
    
    var offset = "" //required
    var limit = "" //required
    
    override init() {
    }
    
    init(offset:String, limit:String) {
        self.offset = offset
        self.limit = limit
    }
    
    override func endPoint() -> String {
        return "/s3k6-pzi2.json?$limit=\(limit)&$offset=\(offset)"
    }
    
    override func isAuthRequired() -> Bool {
        return false
    }
    
    override func requestType() -> RequestType {
        return .GET
    }
    
    override func parameters() -> [String : AnyObject] {
        var parameters: [String:String] = [String:String]()
        
        parameters.updateValue(offset, forKey: "$offset")
        parameters.updateValue(limit, forKey: "$limit")

        return parameters as [String : AnyObject]
    }
    
    override func parser() -> ParserBase {
        return SchoolListParser()
    }
}

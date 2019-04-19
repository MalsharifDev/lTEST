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
    
    
    override func requestType() -> RequestType {
        return .GET
    }

    
    override func parser() -> ParserBase {
        return SchoolListParser()
    }
}

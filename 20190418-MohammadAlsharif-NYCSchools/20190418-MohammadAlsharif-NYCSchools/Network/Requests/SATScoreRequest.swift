//
//  SATScoreRequest.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SATScoreRequest: RequestBase {
    
    var schoolId = "" //required
    
    override init() {
    }
    
    init(schoolId:String) {
        self.schoolId = schoolId
    }
    
    override func endPoint() -> String {
        return "/f9bf-2cp4.json?dbn=\(schoolId)"
    }
    
    override func requestType() -> RequestType {
        return .GET
    }
    
    override func parser() -> ParserBase {
        return SATScoreParser()
    }
}

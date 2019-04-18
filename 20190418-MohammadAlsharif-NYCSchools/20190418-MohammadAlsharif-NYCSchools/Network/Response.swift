//
//  Response.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import Foundation

enum ResponseType : Int {
    case Success
    case Failure
}

class Response {
    
    private(set) var status : ResponseType = .Failure
    var data : AnyObject?
    var httpStatusCode: Int?
    var error: String?
    
    init(data:  Any?, parser: ParserBase, _ httpStatusCode: Int?) {
        
        self.httpStatusCode = httpStatusCode
        
        if let d = data {
            self.data = parser.parseData(data: d)
        }
        if let s = httpStatusCode {
            if (s == 200) {
                self.status = .Success
            } else {
                self.status = .Failure
            }
        }
        
        
    }
    init(error: String?) {
        self.error = error
    }
}

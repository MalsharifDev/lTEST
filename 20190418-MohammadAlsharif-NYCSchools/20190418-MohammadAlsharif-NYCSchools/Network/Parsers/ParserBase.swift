//
//  ParserBase.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import Foundation

class ParserBase {
    
    func parseData(data :  Any) -> AnyObject? {
        return "" as AnyObject?
    }
    
    func parseError(data : Any) -> String? {
        
        let data = data as AnyObject
        let error = data["error"] as? String ?? ""
        if error != "" {
            return error as String
        }
        return nil
    }
}

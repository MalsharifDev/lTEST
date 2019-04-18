//
//  SATScoreParser.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Abhishek on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SATScoreParser: ParserBase {
    
    override func parseData(data:  Any) -> AnyObject? {
        
        var response = SATScoreResponse()
        
        let data = data as AnyObject
        
        response.success = data as? Array<Any>
        
        //parse school list
        let scoreList = data as! [[String: Any]]
        for scoreData in scoreList {
            var score = SATScoreDetails()
            score.score_school_name = scoreData["school_name"] as? String
            score.score_school_id = scoreData["dbn"] as? String
            score.score_num_of_sat_test_takers = scoreData["score_num_of_sat_test_takers"] as? String
            score.score_sat_critical_reading_avg_score = scoreData["sat_critical_reading_avg_score"] as? String
            score.score_sat_math_avg_score = scoreData["sat_math_avg_score"] as? String
            score.score_sat_writing_avg_score = scoreData["sat_writing_avg_score"] as? String
            response.scoreDetails = score
        }
        
        response.error = data["error"] as? Bool ?? false
        response.message = data["message"] as? String ?? "Something went wrong please try again."
        
        return response as AnyObject?
    }
}
struct SATScoreResponse {
    
    var success: Array<Any>?
    var scoreDetails = SATScoreDetails()
    var error: Bool?
    var message: String?
    public init () {
    }
}

struct SATScoreDetails {
    var score_school_id: String?
    var score_school_name: String?
    var score_num_of_sat_test_takers: String?
    var score_sat_critical_reading_avg_score: String?
    var score_sat_math_avg_score: String?
    var score_sat_writing_avg_score: String?
    
    public init () {
    }
}

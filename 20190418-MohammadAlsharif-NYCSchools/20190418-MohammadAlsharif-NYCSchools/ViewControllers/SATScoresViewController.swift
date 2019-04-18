//
//  SATScoresViewController.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SATScoresViewController: BaseViewController {
    var school_id = "01M696"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        callGetSATScoreWebService()
    }
    
    //MARK: -
    func callGetSATScoreWebService() {
        ActivityManager.showActivityIndicator(controller: self, withMessage: "Fetching SATScore...")
        let service = SATScoreService()
        service.fetchScore(school_id: school_id, completionHandler: {
            (response) -> (Void) in
            ActivityManager.hideActivityIndicator(controller: self)
            if response != nil
            {
                if response!.scoreDetails.score_school_id != nil {
                    
                }
                else if response!.error! {
                    self.presentAlertController("", message: response!.message!)
                }
            }
            else
            {
                self.presentAlertController("", message: "Something went wrong please try again.")
            }
        })
    }
    
}

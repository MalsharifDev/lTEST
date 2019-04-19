//
//  SATScoresViewController.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SATScoresViewController: BaseViewController {
    var school_id : String?
    var scoreList = [SATScoreDetails]()
    
    @IBOutlet weak var scoreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "SAT Scores"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Call API to get the SAT Score
        callGetSATScoreWebService()
    }
    
    //MARK: - Call API to get the SAT Score
    func callGetSATScoreWebService() {
        // Show Loader with the text
        ActivityManager.showActivityIndicator(controller: self, withMessage: "Fetching SATScore...")
        let service = SATScoreService()
        service.fetchScore(school_id: school_id!, completionHandler: {
            (response) -> (Void) in
            // Hide the loader view
            ActivityManager.hideActivityIndicator(controller: self)
            if response != nil
            {
                if (response!.scoreDetails.count) > 0 {
                    self.scoreList.append(contentsOf: response!.scoreDetails)
                    self.scoreTableView.reloadData()
                }
                else if (response!.scoreDetails.count) <= 0 {
                    // Show an Alert when got error or no response in the API
                    self.presentAlertController("", message: "No record Found. Please try again.")
                }
                else if response!.error! {
                    // Show an Alert when got error in the API
                    self.presentAlertController("", message: response!.message!)
                }
            }
            else
            {
                // Show an Alert when got error or no response in the API
                self.presentAlertController("", message: "Something went wrong please try again.")
            }
        })
    }
    
}

extension SATScoresViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCellIdentifier") as? ScoreCell
        
        cell?.mathScoreLabel.text = self.scoreList[indexPath.row].score_sat_math_avg_score
        cell?.readingScoreLabel.text = self.scoreList[indexPath.row].score_sat_critical_reading_avg_score
        cell?.writingScoreLabel.text = self.scoreList[indexPath.row].score_sat_writing_avg_score
        cell?.numberOfTestTakers.text = self.scoreList[indexPath.row].score_num_of_sat_test_takers
        cell?.schoolNameTitleLabel.text = self.scoreList[indexPath.row].score_school_name
        
        return cell!
    }
}

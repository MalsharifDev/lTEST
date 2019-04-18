//
//  SchoolListViewController.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SchoolListViewController: BaseViewController {
    
    @IBOutlet weak var schoolListTableView: UITableView!
    var schoolList = [SchoolDetails]()
    var selectedSchoolId : String?
    var offset = 0
    var isLoadingMore = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Schools"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Initialize the SchoolListTable
        initializeSchoolListTableView()
        
        //API call to fetch the School List
        callGetSchoolListWebService()
    }
    
    func initializeSchoolListTableView(){
        schoolListTableView.estimatedRowHeight = UITableView.automaticDimension
        schoolListTableView.rowHeight = UITableView.automaticDimension
    }
    
    //MARK: - API call to fetch the School List
    func callGetSchoolListWebService() {
        if isLoadingMore {
            // Show Loader with the text
            ActivityManager.showActivityIndicator(controller: self, withMessage: "Fetching More Schools...")
        }
        else
        {
            // Show Loader with the text
            ActivityManager.showActivityIndicator(controller: self, withMessage: "Fetching School List...")
        }
        
        let service = SchoolListService()
        // offset is used for the starting point of an record and list used for the no of records
        service.fetchSchools(offset: "\(offset)", limit: "20", completionHandler: {
            (response) -> (Void) in
            // Hide the loader view
            ActivityManager.hideActivityIndicator(controller: self)
            if response != nil
            {
                if (response!.schoolList.count) > 0 {
                    self.schoolList.append(contentsOf: response!.schoolList)
                    self.isLoadingMore = false
                    self.schoolListTableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let nextViewController = segue.destination as? SATScoresViewController {
            nextViewController.school_id = selectedSchoolId!
        }
    }
}

extension SchoolListViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schoolList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolListCellIdentifier") as? SchoolCell
        
        cell?.schoolNameLabel.text = self.schoolList[indexPath.row].school_name
        
        cell?.schoolLocationLabel.text = self.schoolList[indexPath.row].school_address
        
        cell?.schoolWebsiteLabel.text = self.schoolList[indexPath.row].school_website
        
        if !isLoadingMore {
        if indexPath.row == self.schoolList.count - 1 { // last cell
              offset += 20  // increment `offset` by 10 before server call
            isLoadingMore = true
            callGetSchoolListWebService()
        }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedSchoolId = self.schoolList[indexPath.row].school_id!
        
        performSegue(withIdentifier: "toScoreView", sender: self)
        
        
    }
}

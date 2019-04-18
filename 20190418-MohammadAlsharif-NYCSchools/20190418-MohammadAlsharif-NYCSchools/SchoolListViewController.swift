//
//  SchoolListViewController.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class SchoolListViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        callGetSchoolListWebService()
    }
    
    //MARK: -
    func callGetSchoolListWebService() {
        ActivityManager.showActivityIndicator(controller: self, withMessage: "Fetching School List...")
        let service = SchoolListService()
        service.fetchSchools(offset: "0", limit: "10", completionHandler: {
            (response) -> (Void) in
            ActivityManager.hideActivityIndicator(controller: self)
            if response != nil
            {
                if (response!.success!.count) > 0 {
                    
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


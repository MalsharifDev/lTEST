//
//  BaseViewController.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Show alert 
    func presentAlertController(_ title: String, message: String) {
        
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.setNeedsLayout()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

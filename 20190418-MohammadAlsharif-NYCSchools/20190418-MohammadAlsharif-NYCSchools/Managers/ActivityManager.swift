//
//  ActivityManager.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import UIKit
import MBProgressHUD

class ActivityManager: NSObject {
// Show the loader view while controller is waiting for some results
    class func showActivityIndicator(controller:  UIViewController? , withMessage: String?) {
        if controller != nil {
            let hud = MBProgressHUD.showAdded(to: controller!.view, animated: true)
            hud.mode = .indeterminate
            if let message  = withMessage {
                hud.label.text = message
            }
        }
    }

// Hide the loader view once controller got the results
    class func hideActivityIndicator(controller : UIViewController?) {
        
        if controller != nil {
            MBProgressHUD.hide(for: controller!.view, animated: true)
        }
    }
}

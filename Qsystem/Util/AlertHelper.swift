//
//  AlertHelper.swift
//  Qsystem
//
//  Created by Eduardo Hoyos Loli on 7/6/19.
//  Copyright © 2019 Eduardo Hoyos Loli. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    class func notificationAlert(title: String, message:String, viewController : UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let successAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            //NSLog("OK Pressed")
        }
        
        alertController.addAction(successAction)
        
        viewController.present(alertController, animated: true, completion:nil)
    }
}

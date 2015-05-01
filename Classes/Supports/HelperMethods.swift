//
//  HelperMethods.swift
//  Arrived
//
//  Created by Lu Cao on 4/25/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation
import UIKit

// display alert in current viewcontroller
func displayAlert(title: String, message: String) {
    
    let alertController = UIAlertController(title: title,
        message: message,
        preferredStyle: UIAlertControllerStyle.Alert)
    
    alertController.addAction(UIAlertAction(title: "Dismiss",
        style: UIAlertActionStyle.Default,
        handler: nil))
    
    var topController = UIApplication.sharedApplication().keyWindow?.rootViewController
    
    if topController != nil {
        while topController!.presentedViewController != nil {
            topController = topController!.presentedViewController
        }
    }
    
    topController!.presentViewController(alertController, animated: true, completion: nil)
    
//    UIApplication.sharedApplication().keyWindow?.rootViewController?.presentedViewController?.presentViewController(alertController, animated: true, completion: nil)
}

// check error code, if code = 20000, no error and return true
func checkErrorCodeInDictionary(dict: Dictionary<String, AnyObject>?) -> Bool {
    if let code = dict!["code"] as? String {
        if code == "20000" {
            println("Code = 20000, no error")
            return true
        } else {
            displayAlert("Data error", dict!["message"] as! String)
            return false
        }
    } else {
        println("Can not get code from dictionary")
        return false
    }
}


// add a leftview which is an icon to a uitextview
func addIconToUITextFieldLeftView(textField: UITextField, imageName: String) {
    var imageView = UIImageView(image: UIImage(named: imageName))
    textField.leftViewMode = .Always
    imageView.frame = CGRect(x: 0, y: 0, width: textField.frame.height*0.8, height: textField.frame.height*0.8)
    textField.leftView = imageView
}

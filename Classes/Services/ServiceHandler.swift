//
//  ServiceHandler.swift
//  Arrived
//
//  Created by Lu Cao on 4/25/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation
import UIKit

class ServiceHandler: UserService {
    
//    func verify(phoneNumber: String) -> Dictionary<String, AnyObject>? {
//        
//        var dict = Dictionary<String, AnyObject>()
//        
//        verify(phoneNumber) {
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//
//            // print result for testing purpose
//            println(result!)
//            
//            // prompt alert if connection error
//            if error != nil {
//                displayAlert("Connection Error", error!)
//            } else if let code = result!["code"] as? Int {
//                if code == 20000 {
//                    if let data = result!["data"] as? Dictionary<String, AnyObject> {
//                        dict["phoneNumberId"] = data["phoneNumberId"] as? String
//                        dict["verificationCode"] = data["verificationCode"] as? String
//                        dict["isNewUser"] = data["isNewUser"] as? String
//                        println("123")
//                    }
//                }
//            } else {
//                displayAlert("Error retrieving data", result!["message"] as! String)
//            }
//        }
//        
//        return dict
//    }
//    
//    
//    
//    
}
//
//  UserServiceReader.swift
//  Arrived
//
//  Created by Lu Cao on 4/18/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

// UserServiceReader class reads data from UserService and convert them

class UserServiceReader {
    
    private let service = UserService()
    
    
    func getVerificationCode(phoneNumber: String) -> (phoneNumberId: String?, verificationCode: String?, isNewUser: Bool?, message: String?) {
        
        if let dict = service.verify(phoneNumber) {
            let isSuccess = dict["isSuccesss"] as! Bool
            if isSuccess {
                return (dict["phoneNumberId"] as? String, dict["verificationCode"] as? String, dict["isNewUser"] as? Bool, nil)
            } else {
                return (nil, nil, nil, dict["message"] as? String)
            }
            
        } else { return (nil, nil, nil, "Can't connect") }
    }    
    
    
}

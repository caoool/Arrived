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
    
    
    func getVerificationCode(phoneNumber: String) -> String {
        
        
        let code = "000000"
        
        // make sure return 6 digits
        if count(code) == 6 {
            for char in phoneNumber {
                if !("0"..."9" ~= char) {
                    return "error"
                }
            }
            return code
        } else { return "error" }
    }
    
    
    
}

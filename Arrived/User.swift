//
//  File.swift
//  Arrived
//
//  Created by Lu Cao on 4/17/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation
import UIKit

let user = User()

class User {
    
     var phoneNumberId: String?      // user's unique Id
    private var phoneNumber: String?        // user's phone number, different from phoneNumberId
    private var pin: Int?                   // 6 digit pin code used for payments
    
    private var nickname: String?
    private var portrait: UIImage?
    private var sex: Int?
    private var birth: String?
    private var city: String?
    private var address: String?
    private var email: String?
    private var status: String?
    
    private let serviceReader = UserServiceReader()
    private let service = UserService()
    
    func clear() {
        phoneNumberId = nil
        phoneNumber = nil
        pin = nil
        
        nickname = nil
        portrait = nil
        sex = nil
        birth = nil
        city = nil
        address = nil
        email = nil
        status = nil

    }
    
    func verify(phoneNumber: String) -> (code: String?, isNew: Bool?) {
        let result = serviceReader.getVerificationCode(phoneNumber)
        if result.message == nil {
            phoneNumberId = result.phoneNumberId!
            return (result.verificationCode!, result.isNewUser!)
        } else {
            return (result.message!, nil)
        }
    }
    
    func getUserByPhoneNumberId(phoneNumberId: String) {
        if let dict = service.getUserBy(phoneNumberId) {
            let isSuccess = dict["isSuccess"] as! Bool
            if isSuccess {
                nickname = dict["nickname"] as? String
                portrait = dict["portrait"] as? UIImage
                sex      = dict["sex"] as? Int
                birth    = dict["birth"] as? String
                city     = dict["city"] as? String
                address  = dict["address"] as? String
                email    = dict["email"] as? String
                status   = dict["status"] as? String
            } else {
                println(dict["message"])
            }
        } else {
            println("Can't access server")
        }
        
    }
    
    func register(dict: NSDictionary) -> NSDictionary {
        return service.registerWith(dict as [NSObject : AnyObject])
    }
    
    func updateUserInfo(dict: NSDictionary) -> NSDictionary {
        return service.updateWith(dict as [NSObject : AnyObject])
    }
    
}

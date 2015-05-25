//
//  User.swift
//  Arrived
//
//  Created by Lu Cao on 5/2/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

class User {
    
    struct location {
        private var locationId: String
        private var latitude: String
        private var longitude: String
        private var address: String
    }
    
    struct bankCard {
        private var bankCardId: String
        private var fullName: String
        private var bankCardNumber: String
        private var expirationDate: String
        private var cvv: String
    }
    
    var uid : Int? = nil
    var sid : String? = nil
    var regTime : Int? = nil
    var deviceId : String? = nil
    var token : String? = nil
    var sessionValidTime : Int = 3
    
    private var locations = [location]?()
    private var bankCards = [bankCard]?()
    
    func saveLoginInfo() -> Bool{
        var login : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if (uid == nil || sid == nil || regTime == nil || deviceId == nil || token == nil){
            return false
        } else {
            login.setInteger(uid!, forKey: "uid")
            login.setObject(sid, forKey: "sid")
            login.setInteger(regTime!, forKey: "regTime")
            login.setObject(deviceId, forKey: "deviceId")
            login.setObject(token, forKey: "token")
        }
        return true
    }
    
    func verifySession() -> Bool{
        var login = NSUserDefaults.standardUserDefaults()
        let regTime : Int = login.integerForKey("regTime")
        let currentTime = NSDate()
        let curTime = Int(currentTime.timeIntervalSince1970)
        sessionValidTime = sessionValidTime * 24 * 60 * 60
        let temp = regTime + sessionValidTime
        if (temp > curTime){
            return true
        }
        return false
    }
    
    
    

}

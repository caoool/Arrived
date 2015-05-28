//
//  User.swift
//  Arrived
//
//  Created by Lu Cao on 5/2/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

class User {
    
    //User Authentication params
    var uid : Int? = nil
    var sid : String? = nil
    var regTime : Int? = nil
    var deviceId : String? = nil
    var token : String? = nil
    var sessionValidTime : Int = 3
    
    //User Profile
    var nickname : String? = nil
    var portrait : NSData? = nil
    var sex : Int? = nil
    var birth : String? = nil
    var email : String? = nil
    var status : String? = nil
    
    var dataManager = DataManager()
    var listName : String = "profile"
    var path : String = DataManager().path("profile")
    
    func saveLoginInfo() -> Bool{
        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if (uid == nil || sid == nil || regTime == nil || deviceId == nil || token == nil){
            return false
        } else {
            defaults.setInteger(uid!, forKey: "uid")
            defaults.setObject(sid, forKey: "sid")
            defaults.setInteger(regTime!, forKey: "regTime")
            defaults.setObject(deviceId, forKey: "deviceId")
            defaults.setObject(token, forKey: "token")
        }
        return true
    }
    
    func verifySession() -> Bool{
        var defaults = NSUserDefaults.standardUserDefaults()
        let regTime : Int = defaults.integerForKey("regTime")
        let currentTime = NSDate()
        let curTime = Int(currentTime.timeIntervalSince1970)
        sessionValidTime = sessionValidTime * 24 * 60 * 60
        let temp = regTime + sessionValidTime
        if (temp > curTime){
            return true
        }
        return false
    }
    
    func load() -> NSMutableDictionary{
        let fileManager = NSFileManager.defaultManager()
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("\(listName)", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                println("Bundle \(listName).plist file is --> \(resultDictionary?.description)")
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                println("copy")
            } else {
                println("\(listName).plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            println("\(listName).plist already exits at path.")
        }
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Loaded \(listName).plist file is --> \(resultDictionary?.description)")
        return resultDictionary!
    }
    
    func save() -> Bool {
        
        var dict: NSMutableDictionary = NSMutableDictionary()
        
        //saving values
        dict.setObject(nickname!, forKey: "nickname")
        dict.setObject(portrait!, forKey: "portrait")
        dict.setObject(sex!, forKey: "sex")
        dict.setObject(birth!, forKey: "birth")
        dict.setObject(email!, forKey: "email")
        dict.setObject(status!, forKey: "status")
        //...
        //writing to plist
        dict.writeToFile(path, atomically: false)
        return true
    }
    
    func delete() -> Bool {
        return dataManager.delete(path)
    }
    
    
}

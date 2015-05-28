//
//  DataManager.swift
//  Arrive
//
//  Created by Yetian Mao on 5/28/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation

class DataManager {
    
    func path(name : String) -> String {
        // getting path to address.plist
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! String
        let path = documentsDirectory.stringByAppendingPathComponent("\(name).plist")
        return path
    }
    
    
    func load(path : String, name : String) -> NSMutableArray{
        let fileManager = NSFileManager.defaultManager()
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("\(name)", ofType: "plist") {
                let resultArray = NSMutableArray(contentsOfFile: bundlePath)
                println("Bundle \(name).plist file is --> \(resultArray?.description)")
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                println("copy")
            } else {
                println("\(name).plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            println("\(name).plist already exits at path.")
        }
        let resultArray = NSMutableArray(contentsOfFile: path)
        println("Loaded \(name).plist file is --> \(resultArray?.description)")
        return resultArray!
    }
    
    
    func delete(path : String) -> Bool {
        
        let fileManager = NSFileManager.defaultManager()
        if(fileManager.fileExistsAtPath(path)){
            fileManager.removeItemAtPath(path, error: nil)
            return true
        }
        return false
    }
    

}
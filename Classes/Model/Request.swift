//
//  Request.swift
//  Arrive
//
//  Created by Yetian Mao on 5/28/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation


class Request {
    
    var title : String? = nil
    var body : String? = nil
    var price : Int? = nil
    var tags : NSArray? = nil
    var effectiveStartDate : NSDate? = nil
    var effectiveEndDate : NSDate? = nil
    var latitude : Double? = nil
    var longitude : Double? = nil
    var address : String? = nil
    var photos : NSArray? = nil
    var audios : NSArray? = nil
    
    var dataManager = DataManager()
    var path : String = DataManager().path("request")
    
    func load() -> NSMutableArray{
        return dataManager.load(path, name: "request")
    }
    
    func save() -> Bool {
        
        var dict: NSMutableDictionary = NSMutableDictionary()
        
        //saving values
        dict.setObject(title!, forKey: "title")
        dict.setObject(body!, forKey: "body")
        dict.setObject(price!, forKey: "price")
        dict.setObject(tags!, forKey: "tags")
        dict.setObject(effectiveStartDate!, forKey: "effectiveStartDate")
        dict.setObject(effectiveEndDate!, forKey: "effectiveEndDate")
        dict.setObject(latitude!, forKey: "latitude")
        dict.setObject(longitude!, forKey: "longitude")
        dict.setObject(address!, forKey: "address")
        dict.setObject(photos!, forKey: "photos")
        dict.setObject(audios!, forKey: "audios")
        //...
        //writing to plist
        var array: NSMutableArray = self.load()
        array.addObject(dict)
        array.writeToFile(path, atomically: false)
        return true
    }
    
    func delete() -> Bool {
        return dataManager.delete(path)
    }
    
    func deleteOne(index : Int) -> Bool {
        
        var array : NSMutableArray = self.load()
        array.removeObjectAtIndex(index)
        array.writeToFile(path, atomically: false)
        return true
    }

    
    
    
    
}
//
//  Address.swift
//  Arrive
//
//  Created by Yetian Mao on 5/28/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation

class Address{
    
    var addressId: Int? = nil
    var latitude: Double? = nil
    var longitude: Double? = nil
    var address: String? = nil
    
    var dataManager = DataManager()
    var path : String = DataManager().path("address")
    

    func load() -> NSMutableArray{
        return dataManager.load(path, name: "address")
    }
    
    
    func save() -> Bool {
        
        var dict: NSMutableDictionary = NSMutableDictionary()
    
        //saving values
        dict.setObject(addressId!, forKey: "addressId")
        dict.setObject(latitude!, forKey: "latitude")
        dict.setObject(longitude!, forKey: "longitude")
        dict.setObject(address!, forKey: "address")
        //...
        //writing to GameData.plist
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
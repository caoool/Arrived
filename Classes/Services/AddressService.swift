//
//  AddressService.swift
//  Arrived
//
//  Created by Yetian Mao on 5/26/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

class AddressService : HttpService {
    
    var port = Port()
    
    func add(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.location_add, jsonObj: data, callback: callback)
    }
    
    func get(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.location_get, jsonObj: data, callback: callback)
    }
    
}
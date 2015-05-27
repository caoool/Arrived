//
//  UserService.swift
//  Arrive
//
//  Created by Yetian Mao on 4/19/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation

class UserService : HttpService {
    
    var port = Port()
    
    func getOne(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = port.user_getOne + "?" + build(data)!
        getRequest(url, callback: callback)
    }
    
    func update(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        patchRequest(port.user_update, jsonObj: data, callback: callback)
    }
    
    func logout(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        patchRequest(port.user_update, jsonObj: data, callback: callback)
    }
    
    
    
}


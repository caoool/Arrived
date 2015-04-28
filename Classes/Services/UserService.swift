//
//  UserService.swift
//  Arrive
//
//  Created by Yetian Mao on 4/19/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation

class UserService : BaseService {
    
    
    var url = "yetian.xyz"
    
    func verify(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://\(self.url)/api/v1/users/getCode"
        postRequest(url, jsonObj: data, callback: callback)
    }
    
    func authenticate(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://\(self.url)/api/v1/users/auth"
        postRequest(url, jsonObj: data, callback: callback)
    }
    
    func getUserInfo(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://\(self.url)/api/v1/users/get?" + dictToString(data)
        getRequest(url, callback: callback)
    }
    
    func addBankCard(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://\(self.url)/api/v1/users/register"
        postRequest(url, jsonObj: data, callback: callback)
    }
    
    func updateUserInfo(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://\(self.url)/api/v1/users/update"
        patchRequest(url, jsonObj: data, callback: callback)
    }
    
    func addLocation(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://\(self.url)/api/v1/users/addLocation"
        postRequest(url, jsonObj: data, callback: callback)
    }
    
    func getUserBankInfo(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://\(self.url)/api/v1/users/get?" + dictToString(data)
        getRequest(url, callback: callback)
    }
    
}



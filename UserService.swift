//
//  UserService.swift
//  Arrive
//
//  Created by Yetian Mao on 4/19/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation

class UserService : BaseService {
    
    
    func verify(phoneNumber : String, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://yetian.xyz/api/v1/users/verify"
        let data = ["phoneNumber": phoneNumber]
        postRequest(url, jsonObj: data, callback)
        
    }
    
    func authenticate(phoneNumber : String, verificationCode: String, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://yetian.xyz/api/v1/users/auth"
        let data = ["phoneNumber": phoneNumber, "verificationCode": verificationCode]
        postRequest(url, jsonObj: data, callback)
    }
    
    func getUser(phoneNumber : String, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://yetian.xyz/api/v1/users/get?" + "phoneNumber=" + phoneNumber
        getRequest(url, callback)
    }
    
    func register(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://yetian.xyz/api/v1/users/register"
        postRequest(url, jsonObj: data, callback)
    }
    
    func update(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = "http://yetian.xyz/api/v1/users/update"
        patchRequest(url, jsonObj: data, callback)
    }
    
}



//
//  LoginService.swift
//  Arrived
//
//  Created by Yetian Mao on 5/26/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

class LoginService : HttpService {
    
    var port = Port()
    
    //Send Verification Code
    func get(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.login_get, jsonObj: data, callback: callback)
    }
    
    //Authenticate Code
    func auth(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.login_auth, jsonObj: data, callback: callback)
    }
    
}
//
//  UserService.swift
//  Arrive
//
//  Created by Yetian Mao on 4/19/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation

class TestUserService : BaseService {
    
    func addData(data : Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
        var test : Dictionary<String, AnyObject> = ["data": data, "code": "20000", "message": "success"]
        return test
    }
    
    func verify(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        callback(addData(["verificationCode": "123456"]), nil)
    }
    
    func authenticate(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = [
            "uid": "1",
            "verificationCode": "123456",
            "isNewUser": "1"
        ]
        callback(addData(faker), nil)
        
    }
    
    func getUserInfo(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = [
            "uid": "1",
            "nickname": "ha",
            "portrait": "pic.jpg",
            "sex": "1",
            "birth": "May 05, 1992",
            "email": "lalal@qq.com",
            "status": "work",
            "likes": "123",
            "dislikes": "321"
        ]
        callback(addData(faker), nil)
        
    }
    
    func addBankCard(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["nil": "nil"]
        callback(addData(faker), nil)
        
    }
    
    func updateUserInfo(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["nil": "nil"]
        callback(addData(faker), nil)
        
    }
    
    func addLocation(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["nil": "nil"]
        callback(addData(faker), nil)
        
    }
    
    func getUserBankInfo(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = [
            "bankCardId": 1,
            "fullName": "frank",
            "bankCardNumber": "12345666666",
            "expirationDate": "04/12",
            "cvv": "122"
        ]
        callback(addData(faker), nil)
        
    }
    
}
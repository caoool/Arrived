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
    
    func addDataArray(data : [Dictionary<String,  AnyObject>]) -> Dictionary<String, AnyObject> {
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
    
    func updateUserLocationInfo(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["nil": "nil"]
        callback(addData(faker), nil)
        
    }
    
    func getUserLocationInfo(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = [
            "locationId": "2",
            "latitude": "130.12",
            "longitude": "100.13",
            "address": "king st 12304",
            ] as Dictionary<String, AnyObject>;
        var faker2 = [
            "locationId": "1",
            "latitude": "-130.12",
            "longitude": "100.13",
            "address": "bee st 12304",
            ] as Dictionary<String, AnyObject>;
        var faker3 = [
            "locationId": "3",
            "latitude": "-130.12",
            "longitude": "10.13",
            "address": "random st 12304",
            ] as Dictionary<String, AnyObject>;
        var array : [Dictionary<String, AnyObject>] = [faker, faker2, faker3];
        callback(addDataArray(array), nil)
    }
    
    func getUserBankInfo(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = [
            "bankCardId": "1",
            "fullName": "frank",
            "bankCardNumber": "12345666666",
            "expirationDate": "04/12",
            "cvv": "122"
        ]
        var faker2 = [
            "bankCardId": "2",
            "fullName": "bull",
            "bankCardNumber": "1244645666666",
            "expirationDate": "04/16",
            "cvv": "562"
        ]
        var faker3 = [
            "bankCardId": "1",
            "fullName": "rain",
            "bankCardNumber": "12345666666987",
            "expirationDate": "07/19",
            "cvv": "234"
        ]
        var array : [Dictionary<String, AnyObject>] = [faker, faker2, faker3];
        callback(addDataArray(array), nil);
        
    }
    
}


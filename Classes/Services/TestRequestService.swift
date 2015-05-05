//
//  TestRequestService.swift
//  Arrived
//
//  Created by Yetian Mao on 5/5/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation


class TestRequestService : BaseService {
    
    func addData(data : Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
        var test : Dictionary<String, AnyObject> = ["data": data, "code": "20000", "message": "success"]
        return test
    }
    
    func addDataArray(data : [Dictionary<String,  AnyObject>]) -> Dictionary<String, AnyObject> {
        var test : Dictionary<String, AnyObject> = ["data": data, "code": "20000", "message": "success"]
        return test
    }
    
    func post(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var photo = [
            "http://i.imgur.com/YrbaaFr.png",
            "http://i.imgur.com/MJWgIOT.png"
        ]
        
        var audio = [
            "http://music.baidutt.com/up/kwcawawa/yyksud.mp3"
        ]
        
        var faker = [
            "requestId": "1",
            "photo": photo,
            "audio": audio,
        ]
        callback(addData(faker as! Dictionary<String, AnyObject>), nil)
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
    
    func taker(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = [
            "phoneNumber": "13304650123",
            "nickname": "Franko",
            "portrait": "http://i.imgur.com/YrbaaFr.png",
            "status": "Had sex",
            "likes": "123",
            "dislikes": "321",
            "latitude": "100.12",
            "longitude": "134.34",
            "address": "king st.123",
            "requestStatus": "1"
            ] as Dictionary<String, AnyObject>;
        var faker2 = [
            "phoneNumber": "13304651345",
            "nickname": "Dean",
            "portrait": "http://i.imgur.com/YrbaaFr.png",
            "status": "Had sex with Franko",
            "likes": "1234",
            "dislikes": "32",
            "latitude": "10.12",
            "longitude": "132.34",
            "address": "Dead st.123",
            "requestStatus": "0"
            ] as Dictionary<String, AnyObject>;
        var faker3 = [
            "phoneNumber": "13304650123",
            "nickname": "Sam",
            "portrait": "http://i.imgur.com/YrbaaFr.png",
            "status": "Had sex with dean and Franko",
            "likes": "100",
            "dislikes": "10",
            "latitude": "123.12",
            "longitude": "-123.34",
            "address": "rain st.123",
            "requestStatus": "1"
            ] as Dictionary<String, AnyObject>;
        var array : [Dictionary<String, AnyObject>] = [faker, faker2, faker3];
        callback(addDataArray(array), nil)
    }
    
    func pick(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["nil": "nil"]
        callback(addData(faker), nil)
        
    }
    
    func jobs(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var tags = ["emergent", "help", "please"]
        
        var faker = [
            "requestId": "1",
            "phoneNumber": "13304650123",
            "nickname": "Sam",
            "portrait": "http://i.imgur.com/YrbaaFr.png",
            "price": "133",
            "title": "help, need toilet paper",
            "body": "In SCU ENGINEER 1st Floor bathroom, help",
            "effectiveStartDate": "21/06/2015, 12:23:00",
            "effectvieEndDate": "21/06/2015, 12:33:00",
            "tags": tags,
            "latitude": "123.12",
            "longitude": "-123.34",
            "address": "rain st.123",
        ] as Dictionary<String, AnyObject>;
        var faker2 = [
            "requestId": "2",
            "phoneNumber": "13304652222",
            "nickname": "Kyle",
            "portrait": "http://i.imgur.com/YrbaaFr.png",
            "price": "113",
            "title": "sex right now",
            "body": "City center come now",
            "effectiveStartDate": "23/06/2015, 12:23:00",
            "effectvieEndDate": "21/07/2015, 12:23:00",
            "tags": tags,
            "latitude": "126.12",
            "longitude": "-127.34",
            "address": "king st.123",
        ] as Dictionary<String, AnyObject>;
        var faker3 = [
            "requestId": "3",
            "phoneNumber": "13304653333",
            "nickname": "Maokai",
            "portrait": "http://i.imgur.com/YrbaaFr.png",
            "price": "133",
            "title": "need money",
            "body": "money money money",
            "effectiveStartDate": "21/06/2015, 12:23:00",
            "effectvieEndDate": "21/07/2016, 12:33:00",
            "tags": tags,
            "latitude": "123.12",
            "longitude": "-111.34",
            "address": "anywhere st.123",
        ] as Dictionary<String, AnyObject>;
        var array : [Dictionary<String, AnyObject>] = [faker, faker2, faker3];
        callback(addDataArray(array), nil);
        
    }
    
    func intrested(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["status": "1"]
        callback(addData(faker), nil)
    }
    
    func notIntrested(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["nil": "nil"]
        callback(addData(faker), nil)
    }
    
    func accepted(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["nil": "nil"]
        callback(addData(faker), nil)
    }
    
    func finished(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["nil": "nil"]
        callback(addData(faker), nil)
    }
    
}


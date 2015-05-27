//
//  TestReviewService.swift
//  Arrive
//
//  Created by Yetian Mao on 4/19/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation

class TestReviewService : HttpService {
    
    func addData(data : Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
        var test : Dictionary<String, AnyObject> = ["data": data, "code": "20000", "message": "success"]
        return test
    }
    
    func addDataArray(data : [Dictionary<String,  AnyObject>]) -> Dictionary<String, AnyObject> {
        var test : Dictionary<String, AnyObject> = ["data": data, "code": "20000", "message": "success"]
        return test
    }
    
    func rate(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        callback(addData(["reviewId": "1"]), nil)
    }
    
    func delete(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = ["nil": "nil"]
        callback(addData(faker), nil)
    }
    
    func getReviews(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var faker = [
            "like" : "1",
            "message" : "great man"
            ] as Dictionary<String, AnyObject>;
        var faker2 = [
            "like" : "0",
            "message" : "trashy dude"
            ] as Dictionary<String, AnyObject>;
        var faker3 = [
            "like" : "1",
            "message" : "love him"
            ] as Dictionary<String, AnyObject>;
        var array : [Dictionary<String, AnyObject>] = [faker, faker2, faker3];
        callback(addDataArray(array), nil)
    }
    
}


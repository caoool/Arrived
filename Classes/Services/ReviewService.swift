//
//  ReviewService.swift
//  Arrived
//
//  Created by Yetian Mao on 5/26/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

class ReviewService : HttpService {
    
    var port = Port()
    
    func post(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.review_post, jsonObj: data, callback: callback)
    }
    
    func delete(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = port.review_delete + "?" + build(data)!
        deleteRequest(url, callback: callback)
    }
    
    func get(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = port.review_get + "?" + build(data)!
        getRequest(url, callback: callback)
    }
    
}

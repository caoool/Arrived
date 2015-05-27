//
//  RequestService.swift
//  Arrived
//
//  Created by Yetian Mao on 5/26/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

class RequestService : HttpService {
    
    var port = Port()
    
    func post(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.request_post, jsonObj: data, callback: callback)
    }
    
    func takers(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = port.request_takers + "?" + build(data)!
        getRequest(url, callback: callback)
    }
    
    func pick(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.request_pick, jsonObj: data, callback: callback)
    }
    
    func jobs(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = port.request_jobs + "?" + build(data)!
        getRequest(url, callback: callback)
    }
    
    func interested(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.request_interested, jsonObj: data, callback: callback)
    }
    
    func finished(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.request_finished, jsonObj: data, callback: callback)
    }
    
}

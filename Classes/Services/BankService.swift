//
//  BankService.swift
//  Arrived
//
//  Created by Yetian Mao on 5/26/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

class BankService : HttpService {
    
    var port = Port()
    
    func add(data : Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        postRequest(port.bank_add, jsonObj: data, callback: callback)
    }
    
    func get(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = port.bank_get + "?" + build(data)!
        getRequest(url, callback: callback)
    }
    
    func delete(data: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void){
        var url = port.bank_delete + "?" + build(data)!
        getRequest(url, callback: callback)
    }
    
}
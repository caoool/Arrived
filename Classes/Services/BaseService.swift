//
//  BaseService.swift
//  Arrive
//
//  Created by Yetian Mao on 4/19/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation


class BaseService{
    
    func sendHttpRequest(request: NSMutableURLRequest, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(
            request,
            completionHandler: {
                data, response, error in
                if (error != nil) {
                    callback(nil, error.localizedDescription)
                } else {
                    var jsonError : NSError?
                    var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &jsonError) as? Dictionary<String, AnyObject>
                    callback(json, nil)
                }
        })
        
        task.resume()
    }
    
    func getRequest(url: String, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        sendHttpRequest(request, callback: callback)
    }
    
    func deleteRequest(url: String, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "DELETE"
        sendHttpRequest(request, callback: callback)
    }
    
    func postRequest(url: String, jsonObj: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var jsonError : NSError?
        let data : NSData?  = NSJSONSerialization.dataWithJSONObject(jsonObj, options: nil, error: &jsonError)
        request.HTTPBody = data
        sendHttpRequest(request, callback: callback)
    }
    
    func patchRequest(url: String, jsonObj: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var jsonError : NSError?
        let data : NSData?  = NSJSONSerialization.dataWithJSONObject(jsonObj, options: nil, error: &jsonError)
        request.HTTPBody = data
        sendHttpRequest(request, callback: callback)
    }
    
    func jsonParseToDict(jsonString:String) -> Dictionary<String, AnyObject> {
        var error: NSError?
        var data: NSData = jsonString.dataUsingEncoding(
            NSUTF8StringEncoding)!
        var jsonObj = NSJSONSerialization.JSONObjectWithData(
            data,
            options: NSJSONReadingOptions(0),
            error: &error) as! Dictionary<String, AnyObject>
        if (error != nil) {
            return Dictionary<String, AnyObject>()
        } else {
            return jsonObj
        }
    }
    
    func jsonToString(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    func dictToString(data: Dictionary<String, AnyObject>) -> String{
        var params : String = ""
        for(key, value) in data{
            params = params + "\(key)=\(value)&"
        }
        return params
    }
    
}
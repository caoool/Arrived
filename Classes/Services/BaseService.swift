//
//  BaseService.swift
//  Arrive
//
//  Created by Yetian Mao on 4/19/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import Foundation

let errorDomain = "error.domain"

class BaseService{
    var stringEncoding: NSNumber
    var cachePolicy: NSURLRequestCachePolicy
    var timeoutInterval: NSTimeInterval
    var boundary = "BOUNDARY_STRING"
    
    init() {
        self.stringEncoding = NSUTF8StringEncoding
        self.timeoutInterval = 60
        self.cachePolicy = .UseProtocolCachePolicy
    }
    
    //send http request
    func sendHttpRequest(request: NSMutableURLRequest, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(
            request,
            completionHandler: {
                data, response, error in
                if (error != nil) {
                    callback(nil, error.localizedDescription)
                    return
                }
                var httpError : NSError!
                var isValid = self.validateResponse(response, data: data, error: &httpError)
                if (isValid == false) {
                    callback(nil, httpError.localizedDescription)
                    return
                }
                var jsonError : NSError?
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &jsonError) as? Dictionary<String, AnyObject>
                if(jsonError != nil){
                    callback(nil, jsonError?.localizedDescription)
                    return
                }
                callback(json, nil)
        })
        task.resume()
    }
    
    //upload file
    func multiPartUpload(request: NSMutableURLRequest, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        
        let task = NSURLSession.sharedSession().uploadTaskWithRequest(
            request,
            fromData: request.HTTPBody,
            completionHandler: {
                data, response, error in
                if (error != nil) {
                    callback(nil, error.localizedDescription)
                    return
                }
                var httpError : NSError!
                var isValid = self.validateResponse(response, data: data, error: &httpError)
                if (isValid == false) {
                    callback(nil, httpError.localizedDescription)
                    return
                }
                var jsonError : NSError?
                var json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(1), error: &jsonError) as? Dictionary<String, AnyObject>
                callback(json, nil)
        })
        task.resume()
    }
    
    //get
    
    func getRequest(url: String, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        sendHttpRequest(request, callback: callback)
    }
    
    //delete
    
    func deleteRequest(url: String, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.HTTPMethod = "DELETE"
        sendHttpRequest(request, callback: callback)
    }
    
    //post
    
    func postRequest(url: String, jsonObj: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var jsonError : NSError?
        let data : NSData?  = NSJSONSerialization.dataWithJSONObject(jsonObj, options: nil, error: &jsonError)
        request.HTTPBody = data
        sendHttpRequest(request, callback: callback)
    }
    
    //patch
    
    func patchRequest(url: String, jsonObj: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.HTTPMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var jsonError : NSError?
        let data : NSData?  = NSJSONSerialization.dataWithJSONObject(jsonObj, options: nil, error: &jsonError)
        request.HTTPBody = data
        sendHttpRequest(request, callback: callback)
    }
    
    //upload
    
    func multiPartRequest(url: String, jsonObj: Dictionary<String, AnyObject>, callback: (Dictionary<String, AnyObject>?, String?) -> Void) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.HTTPMethod = "POST"
        var contentType = "multipart/form-data; boundary=\(boundary)"
        request.addValue(contentType, forHTTPHeaderField:"Content-Type")
        request.HTTPBody = buildBody(jsonObj)
        sendHttpRequest(request, callback: callback)
        
    }
    
    //form http body for upload
    func buildBody(parameters: [String: AnyObject]) -> NSData {
        var body: NSMutableData = NSMutableData()
        for (key, value) in parameters {
            if (value is NSData) {
                body.appendData("\r\n--\(self.boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                body.appendData("Content-Disposition: form-data; name=\"\(key)\"; filename=\"filename.jpg\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                body.appendData(value as! NSData)
            } else {
                body.appendData("\r\n--\(self.boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                body.appendData("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".dataUsingEncoding(NSUTF8StringEncoding)!)
                
            }
        }
        body.appendData("\r\n--\(self.boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("".dataUsingEncoding(NSUTF8StringEncoding)!)
        return body
    }
    
    //json parse to dictionary
    
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
    
    //json to string
    
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
    
    //turn dictionary to url string params
    
    func dictToString(data: Dictionary<String, AnyObject>) -> String{
        var params : String = ""
        for(key, value) in data{
            params = params + "\(key)=\(value)&"
        }
        return params
    }
    
    //store the http cookie into local cookie storage
    
    func cookieManager(response: NSURLResponse!){
        let httpResp = response as! NSHTTPURLResponse
        var cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(httpResp.allHeaderFields, forURL: httpResp.URL!) as Array
        NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(cookies[0] as! NSHTTPCookie)
        NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(cookies, forURL: httpResp.URL, mainDocumentURL: nil)
    }
    
    //check the http status code
    
    func validateResponse(response: NSURLResponse!, data: NSData!, inout error: NSError!) -> Bool {
        let httpResponse = response as! NSHTTPURLResponse
        var isValid = true
        if (httpResponse.statusCode < 200 && httpResponse.statusCode >= 300) {
            isValid = false
            error = NSError(domain: errorDomain, code: httpResponse.statusCode, userInfo: nil)
        }
        
        return isValid
    }
    
    
    
}
//
//  ViewController.swift
//  Arrive
//
//  Created by Yetian Mao on 4/19/15.
//  Copyright (c) 2015 yetian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test : Dictionary<String, AnyObject> = ["test": "test"]
        
        let service = UserService()
        
        let data = ["test": "test", "view": 1]
        let image = UIImage.init(named:"apple_raw.png")
        let imageData:NSData = UIImageJPEGRepresentation(image, 100)
        let pic = ["thumbnail": imageData, "uid": "1", "verificationCode": "123456"] as Dictionary<String, AnyObject>
        
        //        service.verify("13429239110") {
        //           (data: Dictionary<String, AnyObject>?, error: String?) -> Void in
        //            println(data)
        //        }
        
        //        service.authenticate("13429239110", verificationCode: "789839"){
        //            (data: Dictionary<String, AnyObject>?, error: String?) -> Void in
        //            println(data)
        //        }
        //
        service.getUserInfo(data){
            (data: Dictionary<String, AnyObject>?, error: String?) -> Void in
            println(data)
            println(error)
        }
        //uploadImage(image!)
        
        service.uploadPhoto(pic){
            (data: Dictionary<String, AnyObject>?, error: String?) -> Void in
            println(data)
            println(error)
        }
        //
        //        service.register(test){
        //            (data: Dictionary<String, AnyObject>?, error: String?) -> Void in
        //            println(data)
        //        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    func uploadImage(image:UIImage) {
//        let imageData:NSData = UIImageJPEGRepresentation(image, 100)
//        SRWebClient.POST("http://arrived.dev/api/v1/users/upload")
//            .data(imageData, fieldName:"thumbnail", data: ["foo":"bar","baz":"qux"])
//            .send({(response:AnyObject!, status:Int) -> Void in
//                // process success response
//                },failure:{(error:NSError!) -> Void in
//                    // process failure response
//            })
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


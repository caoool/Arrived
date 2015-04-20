//
//  LoggedInVC.swift
//  Arrived
//
//  Created by Lu Cao on 4/17/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class LoggedInVC: UIViewController {
    
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var statusField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        loadUserInfo()
    }
    
    @IBAction func logout() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("phoneNumberId")
        user.clear()
    }
    
    @IBAction func updateUserInfo() {
        var dict = [String:String]()
        dict["phoneNumberId"] = NSUserDefaults.standardUserDefaults().stringForKey("phoneNumberId")!
        dict["nickname"] = nicknameField.text
        dict["sex"] = sexField.text
        dict["birth"] = birthField.text
        dict["city"] = cityField.text
        dict["address"] = addressField.text
        dict["email"] = emailField.text
        dict["status"] = statusField.text
        
        let service = UserService()
        service.update(dict){
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            
            if error != nil {
                println(error)
                let alertController = UIAlertController(title: "Connection Error",
                    message: "Please check the internet and try again",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss",
                    style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            if let data = result!["data"] as? Dictionary<String, AnyObject> {
                if let isSuccess = data["isSuccess"] as? String {
                    if isSuccess == "true" {
                        println("Successful updated user information")
                    } else {
                        print(result!["code"])
                        println(result!["message"])
                    }
                } else { println("Can't read isSuccess in data") }
            } else { println("Can't read data in result") }
            
        }
        
        loadUserInfo()
    }
    
    func loadUserInfo() {
        let service = UserService()
        service.getUser(NSUserDefaults.standardUserDefaults().stringForKey("phoneNumberId")!){
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            println(result!)
            
            if error != nil {
                println(error)
                let alertController = UIAlertController(title: "Connection Error",
                    message: "Please check the internet and try again",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss",
                    style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
            if let data = result!["data"] as? Dictionary<String, AnyObject> {
                //                if let isSuccess = data["isSuccess"] as? String {
                if true {
                    //                    if isSuccess == "true" {
                    if true {
                        ImageLoader.sharedLoader.imageForUrl("http://upload.wikimedia.org/wikipedia/en/4/43/Apple_Swift_Logo.png", completionHandler:{(image: UIImage?, url: String) in
                            self.portrait.image = image!
                        })
                        dispatch_async(dispatch_get_main_queue(), {
                            self.nicknameField.text = data["nickname"] as? String
                            self.sexField.text = data["sex"] as? String
                            self.birthField.text = data["birth"] as? String
                            self.cityField.text = data["city"] as? String
                            self.addressField.text = data["address"] as? String
                            self.emailField.text = data["email"] as? String
                            self.statusField.text = data["status"] as? String
                        })
                    } else {
                        print(result!["code"])
                        println(result!["message"])
                    }
                } else { println("Can't read isSuccess in data") }
            } else { println("Can't read data in result") }
        }

    }

}

//
//  LoggedInVC.swift
//  Arrived
//
//  Created by Lu Cao on 4/17/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class LoggedInVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    @IBOutlet weak var portrait: UIImageView!
//    @IBOutlet weak var nicknameField: UITextField!
//    @IBOutlet weak var sexField: UITextField!
//    @IBOutlet weak var birthField: UITextField!
//    @IBOutlet weak var cityField: UITextField!
//    @IBOutlet weak var addressField: UITextField!
//    @IBOutlet weak var emailField: UITextField!
//    @IBOutlet weak var statusField: UITextField!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(true)
//        loadUserInfo()
//        var tgr = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
//        portrait.addGestureRecognizer(tgr)
//    }
//    
//    @IBAction func logout() {
//        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("phoneNumberId")
//    }
//    
//    func imageTapped(img: AnyObject)
//    {
//        var image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = .PhotoLibrary
//        image.allowsEditing = true
//        
//        self.presentViewController(image, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
//        println("Picture selected")
//        self.dismissViewControllerAnimated(true, completion: nil)
//        portrait.image = image
//    }
//    
//    @IBAction func updateUserInfo() {
//        
//        var dict = [String:AnyObject]()
//        dict["phoneNumberId"] = NSUserDefaults.standardUserDefaults().stringForKey("phoneNumberId")!
//        dict["nickname"] = nicknameField.text
//        dict["sex"] = sexField.text
//        dict["birth"] = birthField.text
//        dict["city"] = cityField.text
//        dict["address"] = addressField.text
//        dict["email"] = emailField.text
//        dict["status"] = statusField.text
//        dict["portrain"] = portrait.image
//        
//        let service = UserService()
//        service.updateUserInfo(dict){
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//            
//            if error != nil {
//                displayAlert("Connection Error", error!)
//            } else if checkErrorCodeInDictionary(result!) {
//                displayAlert("Success", "User information updated")
//            }
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                self.loadUserInfo()
//            }
//        }
//    }
//    
//    func loadUserInfo() {
//        
//        let service = UserService()
//        
//        service.getUserInfo(NSUserDefaults.standardUserDefaults().stringForKey("phoneNumberId")!) {
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//            
//            println(result!)
//            
//            if error != nil
//            {
//                displayAlert("Connection Error", error!)
//            } else if checkErrorCodeInDictionary(result!)
//            {
//                if let data = result!["data"] as? Dictionary<String, AnyObject>
//                {
//                    dispatch_async(dispatch_get_main_queue()) {
//                        ImageLoader.sharedLoader.imageForUrl("http://upload.wikimedia.org/wikipedia/en/4/43/Apple_Swift_Logo.png", completionHandler:{(image: UIImage?, url: String) in
//                            self.portrait.image = image!
//                        })
//                        self.nicknameField.text = data["nickname"] as? String
//                        self.sexField.text = data["sex"] as? String
//                        self.birthField.text = data["birth"] as? String
//                        self.cityField.text = data["city"] as? String
//                        self.addressField.text = data["address"] as? String
//                        self.emailField.text = data["email"] as? String
//                        self.statusField.text = data["status"] as? String
//                    }
//                }
//            }
//        }
//
//    }

}

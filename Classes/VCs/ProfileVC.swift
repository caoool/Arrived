//
//  ProfileVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/2/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var birth: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var status: UITextField!
    
    @IBOutlet weak var likes: UITextField!
    @IBOutlet weak var dislikes: UITextField!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var bankcard: UILabel!
    
    var locations = [[String:AnyObject]]?()
    var bankCards = [[String:AnyObject]]?()
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // setup portrait view
//        portrait.layer.borderWidth = 3
//        portrait.layer.borderColor = UIColor.whiteColor().CGColor
//        portrait.layer.cornerRadius = 10
//        var tgr = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
//        portrait.addGestureRecognizer(tgr)
//        
//        
//        
//        addIconToUITextFieldLeftView(nickname, "collaborator-104")
//        addIconToUITextFieldLeftView(sex, "toilet-104")
//        addIconToUITextFieldLeftView(birth, "birthday-104")
//        addIconToUITextFieldLeftView(email, "email-104")
//        addIconToUITextFieldLeftView(status, "mental_status-96")
//        addIconToUITextFieldLeftView(likes, "thunbs_up-96")
//        addIconToUITextFieldLeftView(dislikes, "thumbs_down-104")
//        
////        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
////            self.getUserInfo()
////            self.getUserLocationInfo()
////            self.getUserBankInfo()
////        }
//        
//        
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(true)
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//            self.getUserInfo()
////            self.getUserLocationInfo()
////            self.getUserBankInfo()
//        }
//    }
//    
//    func getUserInfo() {
//        var dict = [String:String]()
//        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
//        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
//        
//        let service = TestUserService()
//        service.getUserInfo(dict) {
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//            
//            println(result!)
//            
//            if error != nil {
//                displayAlert("Get User Info - Connection Error", error!)
//            } else if checkErrorCodeInDictionary(result!) {
////                self.portrait.image = result!["data"]["portrait"] as! UIImage
//                // display random pic for testing purpose
////                ImageLoader.sharedLoader.imageForUrl("http://upload.wikimedia.org/wikipedia/en/4/43/Apple_Swift_Logo.png", completionHandler:{(image: UIImage?, url: String) in
////                    self.portrait.image = image!
////                })
//                self.nickname.text = result!["data"]!["nickname"] as? String
//                self.sex.text = (result!["data"]!["nickname"] as? String == "0") ? "male" : "female"
//                self.birth.text = result!["data"]!["birth"] as? String
//                self.email.text = result!["data"]!["email"] as? String
//                self.status.text = result!["data"]!["status"] as? String
//                self.likes.text = result!["data"]!["likes"] as? String
//                self.dislikes.text = result!["data"]!["dislikes"] as? String
//
//            }
//            
//        }
//    }
//    
//    func getUserLocationInfo() {
//        var dict = [String:String]()
//        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
//        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
//        
//        let service = TestUserService()
//        service.getUserLocationInfo(dict) {
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//            
//            println(result!)
//            
//            if error != nil {
//                displayAlert("Get User Info - Connection Error", error!)
//            } else if checkErrorCodeInDictionary(result!) {
//                self.locations = result!["data"] as? [[String:AnyObject]]
//                self.address.text = self.locations![0]["address"] as? String
//            }
//            
//        }
//    }
//    
//    func getUserBankInfo() {
//        var dict = [String:String]()
//        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
//        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
//        
//        let service = TestUserService()
//        service.getUserBankInfo(dict) {
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//            
//            println(result!)
//            
//            if error != nil {
//                displayAlert("Get User Info - Connection Error", error!)
//            } else if checkErrorCodeInDictionary(result!) {
//                self.bankCards = result!["data"] as? [[String:AnyObject]]
//                self.bankcard.text = self.bankCards![0]["bankCardNumber"] as? String
//            }
//            
//        }
//    }
//    
//    
//    func updateUserInfo() {
//        var dict = [String:String]()
//        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
//        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
//        dict["nickname"] = nickname.text
//        dict["sex"] = (sex.text == "male") ? "0" : "1"
//        dict["birth"] = birth.text
//        dict["email"] = email.text
//        dict["status"] = status.text
//        
//        let service = TestUserService()
//        service.updateUserInfo(dict) {
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//            
//            if error != nil {
//                displayAlert("Get User Info - Connection Error", error!)
//            } else if checkErrorCodeInDictionary(result!) {
//                displayAlert("Success", "User Information Updated")
//                self.editButton.title = "Edit"
//            }
//        }
//    }
//    
//    @IBAction func edit(sender: UIBarButtonItem) {
//        switch sender.title! {
//        case "Edit":
//            nickname.userInteractionEnabled = true
//            sex.userInteractionEnabled = true
//            birth.userInteractionEnabled = true
//            email.userInteractionEnabled = true
//            status.userInteractionEnabled = true
//            sender.title = "Done"
//        case "Done":
//            updateUserInfo()
//            
//        default:
//            return
//        }
//    }
//    
//    func imageTapped(img: AnyObject) {
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


    @IBAction func logout() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("uid")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("phoneNumber")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("verificationCode")
        
        performSegueWithIdentifier("Logout ", sender: self)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "ProfileEditLocations") {
//            var svc = segue.destinationViewController as! UserLocationsTVC
//            svc.toPass = locations!
//        }
//        
//        if (segue.identifier == "ProfileEditBankCards") {
//            var svc = segue.destinationViewController as! UserBankCardsTVC
//            svc.toPass = bankCards!
//        }
//    }
    

}

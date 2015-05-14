//
//  WelcomeVC.swift
//  Arrived
//
//  Created by Lu Cao on 4/17/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import CoreTelephony
import SHSPhoneComponent

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var phoneNumberField: SHSPhoneTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUILook()
        
    }
    
    // MARK: - Initializations
    
    // set up some ui looks
    func setUpUILook() {
        
        // adding a single bottom border to the button
        var border = CALayer()
        var width = CGFloat(0.5)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: phoneNumberField.frame.size.width * 0.075, y: phoneNumberField.frame.size.height - width, width: phoneNumberField.frame.size.width * 0.85, height: phoneNumberField.frame.size.height)
        border.borderWidth = width
        
        phoneNumberField.layer.addSublayer(border)
        phoneNumberField.layer.masksToBounds = true
    }
    
    // format phone number and add flag
    // TODO: Need add support for more country code
    func formatPhoneNumberWithFlag() {
        phoneNumberField.becomeFirstResponder()
        
        phoneNumberField.formatter.setDefaultOutputPattern("(###)###-####", imagePath: nil)
        phoneNumberField.formatter.prefix = "+1 "
        phoneNumberField.formatter.addOutputPattern("(###) ###-###", forRegExp:"^[0-9]\\d*$", imagePath:"SHSPhoneImage.bundle/flag_us")
    }
    
    // FIXME: - Automatic pull country code from carrier
    func setUpCarrier() {
        let network_Info = CTTelephonyNetworkInfo()
        let carrier = network_Info.subscriberCellularProvider
        println(carrier.mobileCountryCode)
    }
    
    
    // MARK: - Funtionalities
    
    @IBAction func numberTapped(sender: UIButton) {
        
        formatPhoneNumberWithFlag()
        
        if let digit = sender.titleLabel?.text {
            switch digit {
            case "1","2","3","4","5","6","7","8","9","0":
                phoneNumberField.text? += digit
            case "+":
                if phoneNumberField.text.isEmpty { phoneNumberField.text? += digit }
            case "←":
                if !phoneNumberField.text.isEmpty {
                    phoneNumberField.text = dropLast(phoneNumberField.text)
                }
            default:
                return
            }
        }
    }

    @IBAction func buttonTapped(sender: UIButton) {
        println(phoneNumberField.formatter.digitOnlyString(phoneNumberField.text))
    }
    
//    @IBOutlet weak var logoLabel: UILabel!
//    @IBOutlet weak var phone: UITextField!
//    @IBOutlet weak var sms: UITextField!
//    
//    @IBOutlet weak var smsButton: UIButton!
//    @IBOutlet weak var LoginButton: UIButton!
//    
//    private var phoneNumberId: String?
//    private var verificationCode: String?
//    private var isNewUser: String?
//    
//    private var timeBeforeNextSMS: Int = 60
//    private var timer: NSTimer?
//    
//    private let service = TestUserService()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        logoLabel.layer.cornerRadius = 35
//        smsButton.layer.cornerRadius = 10
//        
//        var imageView = UIImageView()
//        var image = UIImage(named: "Phone Icon.png")
//        imageView.image = image
//        phone.layer.cornerRadius = 2
//        sms.layer.cornerRadius = 2
//        phone.leftViewMode = UITextFieldViewMode.Always
//        phone.leftView = imageView
//        sms.hidden = true
//        LoginButton.hidden = true
//        
//    }
//    
//    func count() {
//        smsButton.setTitle("\(--timeBeforeNextSMS)", forState: .Disabled)
//        if timeBeforeNextSMS < 1 {
//            timer?.invalidate()
//            timeBeforeNextSMS = 59
//        }
//    }
//    
//    @IBAction func smsButtonPressed() {
//        
//        service.verify(["phoneNumber":phone.text]) {
//            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//            
//            // print result for testing purpose
//            println(result!)
//            
//            // prompt alert if connection error
//            if error != nil
//            {
//                displayAlert("Verify - Connection Error", error!)
//                return
//            }
//            
//            // check code from result, if code = 20000, no error, vise versa
//            if checkErrorCodeInDictionary(result!) {
//                // disable button and reactive after time
//                dispatch_async(dispatch_get_main_queue()) {
//                    self.smsButton.enabled = false
//                    self.smsButton.setTitle("60", forState: .Disabled)
//                    self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("count"), userInfo: nil, repeats: true)
//                    self.sms.hidden = false
//                    self.LoginButton.hidden = false
//                }
//            }
//        }
//        
//    }
//
//    @IBAction func loginButtonPressed() {
//        
//        if sms.text == nil {
//            // display alert if sms code doesn't match
//            displayAlert("SMS Code Error", "Please make sure to enter the correct sms code")
//        } else {
//            
//            var dict = Dictionary<String, AnyObject>()
//            dict["phoneNumber"] = phone.text
//            dict["verificationCode"] = sms.text
//            service.authenticate(dict) {
//                (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
//                
//                // print result for testing purpose
//                println(result!)
//                
//                // prompt alert if connection error
//                if error != nil
//                {
//                    displayAlert("Verify - Connection Error", error!)
//                    return
//                }
//                
//                // check code from result, if code = 20000, no error, vise versa
//                if checkErrorCodeInDictionary(result!) {
//                    let uid = result!["data"]!["uid"] as? String
//                    let isNewUser = result!["data"]!["isNewUser"] as? String
//                    let verificationCode = result!["data"]!["verificationCode"] as? String
//                    
//                    println("uid = \(uid)")
//                    println("isNewUser = \(isNewUser)")
//                    println("verificationCode = \(verificationCode)")
//                    
//                    NSUserDefaults.standardUserDefaults().setValue(uid, forKey: "uid")
//                    NSUserDefaults.standardUserDefaults().setValue(verificationCode, forKey: "verificationCode")
//                    NSUserDefaults.standardUserDefaults().setValue(self.phone.text, forKey: "phoneNumber")
//                    
//                    if isNewUser! == "1" {
//                        println("Auth - New User")
//                        self.performSegueWithIdentifier("WelcomeSignUp", sender: self)
//                    } else {
//                        println("Auth - Existing User")
//                        self.performSegueWithIdentifier("WelcomeLogin", sender: self)
//                    }
//                }
//                
//                
//            }
//        }
//    }
    
    

}

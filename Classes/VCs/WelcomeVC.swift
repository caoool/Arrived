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
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var phoneNumberField: SHSPhoneTextField!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var next: UIButton!
    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!

    @IBOutlet weak var passwordField1: UITextField!
    @IBOutlet weak var passwordField2: UITextField!
    @IBOutlet weak var passwordField3: UITextField!
    @IBOutlet weak var passwordField4: UITextField!
    @IBOutlet weak var passwordField5: UITextField!
    @IBOutlet weak var passwordField6: UITextField!
    
    private var passwordFields = [UITextField]()
    
    @IBOutlet weak var resendLabel: UILabel!
    
    private var timeBeforeNextSMS: Int = 60
    private var timer: NSTimer?
    private var buttonColor: UIColor?
    private var buttonFont: UIFont?
    private var buttonText: String?
    private var verificationCode: String? {
        get {
            return passwordField1.text + passwordField2.text + passwordField3.text + passwordField4.text + passwordField5.text + passwordField6.text
        }
    }
    private var isEnteringVerificationCode: Bool = false
    private var pinPosition: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVariable()
        setupUILook()
        
    }
    
    // MARK: - Initializations
    
    func setupVariable() {
        
        passwordFields.append(passwordField1)
        passwordFields.append(passwordField2)
        passwordFields.append(passwordField3)
        passwordFields.append(passwordField4)
        passwordFields.append(passwordField5)
        passwordFields.append(passwordField6)
    }
    
    // set up some ui looks
    func setupUILook() {
        
        // adding a single bottom border to the button
        var border = CALayer()
        var width = CGFloat(0.5)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: phoneNumberField.frame.size.width * 0.075, y: phoneNumberField.frame.size.height - width, width: phoneNumberField.frame.size.width * 0.85, height: phoneNumberField.frame.size.height)
        border.borderWidth = width
        
        phoneNumberField.layer.addSublayer(border)
        phoneNumberField.layer.masksToBounds = true
        
        for item in passwordFields {
            item.hidden = true
        }
        
        resendLabel.hidden = true
    }
    
    // format phone number and add flag
    // TODO: Need add support for more country code
    func formatPhoneNumberWithFlag() {
        phoneNumberField.becomeFirstResponder()
        
        phoneNumberField.formatter.setDefaultOutputPattern("(###) ### - ####", imagePath: nil)
        phoneNumberField.formatter.prefix = "+1 "
        phoneNumberField.formatter.addOutputPattern("(###) ### - ###", forRegExp:"^[0-9]\\d*$", imagePath:"SHSPhoneImage.bundle/flag_us")
    }
    
    // FIXME: - Automatic pull country code from carrier
    func setupCarrier() {
        let network_Info = CTTelephonyNetworkInfo()
        let carrier = network_Info.subscriberCellularProvider
        println(carrier.mobileCountryCode)
    }

    
    // MARK: - Funtionalities
    @IBAction func numberTapped(sender: UIButton) {
        
        if !isEnteringVerificationCode
        {
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
        } else
        {
            if let digit = sender.titleLabel?.text {
                switch digit {
                case "1","2","3","4","5","6","7","8","9","0":
                    if pinPosition < 6 { passwordFields[pinPosition++ - 1].text = digit }
                    else if pinPosition == 6 {
                        passwordFields[pinPosition++ - 1].text = digit
                        authenticateAndGotoNextScreen()
                    }
                case "←":
                    if pinPosition > 1 { passwordFields[--pinPosition - 1].text = "" }
                case "↻":
                    switchPlusSignBack()
                    fadeAndSwitchLabelBack()
                    moveDownPhoneHideVerification()
                    changeButtonToWait()
                    isEnteringVerificationCode = false
                default:
                    return
                }
            }
        }
        
        
    }

    @IBAction func buttonTapped(sender: UIButton) {
        
        if count(phoneNumberField.phoneNumber()) != 11 {
            GoogleWearAlert.showAlert(title: "Phone Num", image: nil, type: .Error, duration: 1.2, inViewController: self, atPostion: .Center, canBeDismissedByUser: true)
            return
        }
        
        isEnteringVerificationCode = true
        switchPlusSign()
        fadeAndSwitchLabel()
        moveUpPhoneShowVerification()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("counter"), userInfo: nil, repeats: true)
    }
    
    
    // TODO: - Authenticate with the server, wait indicator and alert
    func authenticateAndGotoNextScreen() {
        println(verificationCode)
    }
    
    // MARK: - UI Work
    func switchPlusSign() {
        plus.transform = CGAffineTransformMakeScale(0.1, 0.1)
        plus.setTitle("↻", forState: UIControlState.Normal)
        plus.setTitleColor(next.backgroundColor, forState: UIControlState.Normal)
        UIView.animateWithDuration(2.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.plus.transform = CGAffineTransformMakeScale(1.6, 1.6)
            }, completion: nil)
    }
    
    func switchPlusSignBack() {
        plus.transform = CGAffineTransformMakeScale(1.6, 1.6)
        plus.setTitle("+", forState: UIControlState.Normal)
        plus.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        UIView.animateWithDuration(2.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.plus.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    func fadeAndSwitchLabel() {
        // Fade out to set the text
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.textLabel.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                
                //Once the label is completely invisible, set the text and fade it back in
                self.textLabel.text = "Please enter your verification code"
                
                // Fade in
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.textLabel.alpha = 1.0
                    }, completion: nil)
        })
    }
    
    func fadeAndSwitchLabelBack() {
        // Fade out to set the text
        UIView.animateWithDuration(0.6, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.textLabel.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                
                //Once the label is completely invisible, set the text and fade it back in
                self.textLabel.text = "Please enter your phone number to receive a verification code"
                
                // Fade in
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.textLabel.alpha = 1.0
                    }, completion: nil)
        })
    }
    
    func counter() {
        resendLabel.text = "Resend sms in \(--timeBeforeNextSMS) seconds"
        if timeBeforeNextSMS < 1 {
            timer?.invalidate()
            timeBeforeNextSMS = 59
            
            // reset the button
            next.enabled = true
            next.backgroundColor = buttonColor
            next.titleLabel!.font = buttonFont
            next.titleLabel!.text = buttonText
            
            resendLabel.hidden = true
        }
    }
    
    func changeButtonToWait() {
        if timeBeforeNextSMS > 1 {
            resendLabel.hidden = false
            
            next.enabled = false
            buttonFont = next.titleLabel!.font
            next.titleLabel!.font = next.titleLabel!.font.fontWithSize(24)
            buttonColor = next.backgroundColor
            next.backgroundColor = UIColor.grayColor()
            buttonText = next.titleLabel!.text!
            next.setTitle("", forState: .Disabled)
        }
    }
    
    func moveUpPhoneShowVerification() {

        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.bottomSpaceConstraint.constant += 35
            self.phoneNumberField.center.y = self.phoneNumberField.center.y - 35
            
            for item in self.passwordFields {
                item.alpha = 0
            }
            }, completion: {
                (finished: Bool) -> Void in

                UIView.animateWithDuration(0.6, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    for item in self.passwordFields {
                        item.hidden = false
                        item.alpha = 1
                    }
                    }, completion: nil)
        })
    }
    
    func moveDownPhoneHideVerification() {
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            for item in self.passwordFields {
                item.alpha = 0
            }
            }, completion: {
                (finished: Bool) -> Void in
                
                for item in self.passwordFields {
                    item.hidden = true
                }
                
                UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.bottomSpaceConstraint.constant -= 35
                    self.phoneNumberField.center.y = self.phoneNumberField.center.y + 35
                    }, completion: nil)
        })
    }
    
    /*

    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var sms: UITextField!
    
    @IBOutlet weak var smsButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    private var phoneNumberId: String?
    private var verificationCode: String?
    private var isNewUser: String?
    
    private var timeBeforeNextSMS: Int = 60
    private var timer: NSTimer?
    
    private let service = TestUserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoLabel.layer.cornerRadius = 35
        smsButton.layer.cornerRadius = 10
        
        var imageView = UIImageView()
        var image = UIImage(named: "Phone Icon.png")
        imageView.image = image
        phone.layer.cornerRadius = 2
        sms.layer.cornerRadius = 2
        phone.leftViewMode = UITextFieldViewMode.Always
        phone.leftView = imageView
        sms.hidden = true
        LoginButton.hidden = true
        
    }
    
    func count() {
        smsButton.setTitle("\(--timeBeforeNextSMS)", forState: .Disabled)
        if timeBeforeNextSMS < 1 {
            timer?.invalidate()
            timeBeforeNextSMS = 59
        }
    }
    
    @IBAction func smsButtonPressed() {
        
        service.verify(["phoneNumber":phone.text]) {
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            
            // print result for testing purpose
            println(result!)
            
            // prompt alert if connection error
            if error != nil
            {
                displayAlert("Verify - Connection Error", error!)
                return
            }
            
            // check code from result, if code = 20000, no error, vise versa
            if checkErrorCodeInDictionary(result!) {
                // disable button and reactive after time
                dispatch_async(dispatch_get_main_queue()) {
                    self.smsButton.enabled = false
                    self.smsButton.setTitle("60", forState: .Disabled)
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("count"), userInfo: nil, repeats: true)
                    self.sms.hidden = false
                    self.LoginButton.hidden = false
                }
            }
        }
        
    }

    @IBAction func loginButtonPressed() {
        
        if sms.text == nil {
            // display alert if sms code doesn't match
            displayAlert("SMS Code Error", "Please make sure to enter the correct sms code")
        } else {
            
            var dict = Dictionary<String, AnyObject>()
            dict["phoneNumber"] = phone.text
            dict["verificationCode"] = sms.text
            service.authenticate(dict) {
                (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
                
                // print result for testing purpose
                println(result!)
                
                // prompt alert if connection error
                if error != nil
                {
                    displayAlert("Verify - Connection Error", error!)
                    return
                }
                
                // check code from result, if code = 20000, no error, vise versa
                if checkErrorCodeInDictionary(result!) {
                    let uid = result!["data"]!["uid"] as? String
                    let isNewUser = result!["data"]!["isNewUser"] as? String
                    let verificationCode = result!["data"]!["verificationCode"] as? String
                    
                    println("uid = \(uid)")
                    println("isNewUser = \(isNewUser)")
                    println("verificationCode = \(verificationCode)")
                    
                    NSUserDefaults.standardUserDefaults().setValue(uid, forKey: "uid")
                    NSUserDefaults.standardUserDefaults().setValue(verificationCode, forKey: "verificationCode")
                    NSUserDefaults.standardUserDefaults().setValue(self.phone.text, forKey: "phoneNumber")
                    
                    if isNewUser! == "1" {
                        println("Auth - New User")
                        self.performSegueWithIdentifier("WelcomeSignUp", sender: self)
                    } else {
                        println("Auth - Existing User")
                        self.performSegueWithIdentifier("WelcomeLogin", sender: self)
                    }
                }
                
                
            }
        }
    }
    
    */
    

}

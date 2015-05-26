//
//  UserMenuVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/24/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class UserMenuVC: UIViewController, UITextFieldDelegate {
    
    // create instance of our custom transition manager
    let transitionManager = MenuTransitionManager()
    
    @IBOutlet weak var phoneIcon: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var pinIcon: UIButton!
    @IBOutlet weak var pinLabel: UILabel!
    
    @IBOutlet weak var addressIcon: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var cardIcon: UIButton!
    @IBOutlet weak var cardLabel: UILabel!
    
    @IBOutlet weak var logoutIcon: UIButton!
    @IBOutlet weak var logoutLabel: UILabel!
    
    @IBOutlet weak var supportIcon: UIButton!
    @IBOutlet weak var supportLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    private var pinChanngeTextField1: UITextField!
    private var pinChanngeTextField2: UITextField!
    private var pinChanngeTextField3: UITextField!
    private var pinChanngeTextField4: UITextField!
    
    private var phoneChanngeTextField1: UITextField!
    private var phoneChanngeTextField2: UITextField!
    private var phoneChanngeTextField3: UITextField!
    private var phoneChanngeTextField4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self.transitionManager
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        cancelButton.layer.cornerRadius = cancelButton.frame.height/2
    }
    
    // MARK: - Functionalities
    
    @IBAction func changePin(sender: UIButton) {
        let alert = AlertController(title: "Pin Code", message: "We need to verify you identity in order to protect your account, please enter verification code sent to your phone number 😘", style: .Alert)
        showChangePinAlert(alert)
    }
    
    func showChangePinAlert(alert: SimpleAlert.Controller) {
        
        var verificationCode: Int?
        var oldPin: Int?
        var newPin: Int?
        var newPin2: Int?
        
        alert.addTextFieldWithConfigurationHandler() { textField in
            self.addDoneButtonOnKeyboard(textField)
            self.pinChanngeTextField1 = textField
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "Verification code"
        }
        
        alert.addTextFieldWithConfigurationHandler() { textField in
            self.addDoneButtonOnKeyboard(textField)
            self.pinChanngeTextField2 = textField
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "Old pin code"
            textField.secureTextEntry = true
        }
        
        alert.addTextFieldWithConfigurationHandler() { textField in
            self.addDoneButtonOnKeyboard(textField)
            self.pinChanngeTextField3 = textField
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "New pin code"
            textField.secureTextEntry = true
        }
        
        alert.addTextFieldWithConfigurationHandler() { textField in
            self.addDoneButtonOnKeyboard(textField)
            self.pinChanngeTextField4 = textField
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "New pin code again"
            textField.secureTextEntry = true
        }
        
        alert.addAction(SimpleAlert.Action(title: "Resend ↻", style: .Default) { action in

            })
        
        alert.addAction(SimpleAlert.Action(title: "Confirm", style: .OK) { action in
            
            verificationCode = (alert.textFields[0] as UITextField).text.toInt()
            oldPin = (alert.textFields[1] as UITextField).text.toInt()
            newPin = (alert.textFields[2] as UITextField).text.toInt()
            newPin2 = (alert.textFields[3] as UITextField).text.toInt()
            })
        
        alert.addAction(SimpleAlert.Action(title: "⇠", style: .Cancel) { action in

            })
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func changePhone(sender: UIButton) {
        let alert = AlertController(title: "Phone Number", message: "We need to verify you identity in order to protect your account, please enter verification code sent to your phone number 😘", style: .Alert)
        showChangePhoneAlert(alert)
    }
    
    func showChangePhoneAlert(alert: SimpleAlert.Controller) {
        
        var verificationCode: Int?
        var oldPhone: Int?
        var newPhone: Int?
        
        alert.addTextFieldWithConfigurationHandler() { textField in
            self.addDoneButtonOnKeyboard(textField)
            self.phoneChanngeTextField1 = textField
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "Verification code"
        }
        
        alert.addTextFieldWithConfigurationHandler() { textField in
            self.addDoneButtonOnKeyboard(textField)
            self.phoneChanngeTextField2 = textField
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "Old phone number"
        }
        
        alert.addTextFieldWithConfigurationHandler() { textField in
            self.addDoneButtonOnKeyboard(textField)
            self.phoneChanngeTextField3 = textField
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "New phone number"
        }
        
        alert.addAction(SimpleAlert.Action(title: "Resend ↻", style: .Default) { action in
            
            })
        
        alert.addAction(SimpleAlert.Action(title: "Get Verification ⇢", style: .OK) { action in
            
            verificationCode = (alert.textFields[0] as UITextField).text.toInt()
            oldPhone = (alert.textFields[1] as UITextField).text.toInt()
            newPhone = (alert.textFields[2] as UITextField).text.toInt()
            
            let alert = AlertController(title: "Verify", message: "We need to verify you identity in order to protect your account, please enter verification code sent to your phone number 😘", style: .Alert)
            self.showChangePhoneVerificationAlert(alert)
            })
        
        alert.addAction(SimpleAlert.Action(title: "⇠", style: .Cancel) { action in
            
            })
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showChangePhoneVerificationAlert(alert: SimpleAlert.Controller) {
        
        var verificationCode: Int?
        
        alert.addTextFieldWithConfigurationHandler() { textField in
            self.addDoneButtonOnKeyboard(textField)
            self.phoneChanngeTextField4 = textField
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "Verification code"
        }
        
        alert.addAction(SimpleAlert.Action(title: "resend ↻", style: .Default) { action in
            
            })
        
        alert.addAction(SimpleAlert.Action(title: "Confirm", style: .OK) { action in
            verificationCode = (alert.textFields[0] as UITextField).text.toInt()
            })
        
        alert.addAction(SimpleAlert.Action(title: "⇠", style: .Cancel) { action in
            
            })
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // add a ui tool bar above each keyboard, and done
    func addDoneButtonOnKeyboard(myTextField: UITextField)
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.Default
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var fixedSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        done.tintColor = myTextField.textColor
        
        var items = NSMutableArray()

        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = items as [AnyObject]
        doneToolbar.sizeToFit()
        doneToolbar.backgroundColor = UIColor.whiteColor()
        
        myTextField.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction()
    {
        if pinChanngeTextField1.isFirstResponder() {
            pinChanngeTextField1.resignFirstResponder()
        } else if pinChanngeTextField2.isFirstResponder() {
            pinChanngeTextField2.resignFirstResponder()
        } else if pinChanngeTextField3.isFirstResponder() {
            pinChanngeTextField3.resignFirstResponder()
        }  else if pinChanngeTextField4.isFirstResponder() {
            pinChanngeTextField4.resignFirstResponder()
        } else if phoneChanngeTextField1.isFirstResponder() {
            phoneChanngeTextField1.resignFirstResponder()
        } else if phoneChanngeTextField2.isFirstResponder() {
            phoneChanngeTextField2.resignFirstResponder()
        } else if phoneChanngeTextField3.isFirstResponder() {
            phoneChanngeTextField3.resignFirstResponder()
        }  else if phoneChanngeTextField4.isFirstResponder() {
            phoneChanngeTextField4.resignFirstResponder()
        }
    }
    
    // MARK: - Navigations
    
    @IBAction func unwindToMainViewController(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

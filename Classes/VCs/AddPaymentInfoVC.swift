//
//  AddPaymentInfoVC.swift
//  Arrived
//  Bank info recording is not implemented
//  This feature will be added as soon as the backend is ready
//
//  Created by Lu Cao on 4/19/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class AddPaymentInfoVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var cardLabel: UITextField!
    @IBOutlet weak var expDateLabel: UITextField!
    @IBOutlet weak var cvvLabel: UITextField!
    @IBOutlet weak var pinLabel: UITextField!
    @IBOutlet weak var pin2Label: UITextField!
    
    private var isSuccess: Bool?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addIconToUITextFieldLeftView(nameLabel, "user-104")
        addIconToUITextFieldLeftView(cardLabel, "credit_card-100")
        addIconToUITextFieldLeftView(expDateLabel, "today-100")
        addIconToUITextFieldLeftView(pinLabel, "key-100")
        addIconToUITextFieldLeftView(pin2Label, "key-100")
        

    }
    
    @IBAction func datePicker(sender: UITextField) {
        var datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/yy"
        expDateLabel.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func register() {
        
        // check if pin is correctly entered
        if pinLabel.text != pin2Label.text || count(pin2Label.text) != 6 || pin2Label.text ~= "^([0-9]+)?(\\.([0-9]{1,2})?)?$" {
            displayAlert("Pin error", "Please enter the same 6 digit pin code")
            return
        }
        
        var dict = [String:String]()
        dict["uid"] = NSUserDefaults.standardUserDefaults().stringForKey("uid")
        dict["verificationCode"] = NSUserDefaults.standardUserDefaults().stringForKey("verificationCode")
        dict["fullName"] = nameLabel.text
        dict["bankCardNumber"] = cardLabel.text
        dict["expirationDate"] = expDateLabel.text
        dict["cvv"] = cvvLabel.text
        dict["pinCode"] = pin2Label.text
        
        let service = TestUserService()
        service.addBankCard(dict) {
            (result: Dictionary<String, AnyObject>?, error: String?) -> Void in
            
            if checkErrorCodeInDictionary(result!) {
                self.performSegueWithIdentifier("AddPaymentInfoNewUserCreated", sender: self)
            }
            
        }

    }

    @IBAction func setUpLater() {
        performSegueWithIdentifier("AddPaymentInfoNewUserCreated", sender: self)
    }
    
}

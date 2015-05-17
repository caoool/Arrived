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

class AddPaymentInfoVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bankCardNumberField: UITextField!
    @IBOutlet weak var cardHolderNameField: UITextField!
    @IBOutlet weak var expDateField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
    
    private var textFields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UI Work
    
    func setupUI() {
        
        self.addDoneButtonOnKeyboard()
        bankCardNumberField.becomeFirstResponder()
        
        textFields = [bankCardNumberField, cardHolderNameField, expDateField, cvvField]
        for item in textFields {
            
            // adding a single bottom border to the button
            var border = CALayer()
            var width = CGFloat(0.5)
            border.borderColor = UIColor.darkGrayColor().CGColor
            border.frame = CGRect(x: 0, y: item.frame.size.height - width, width: item.frame.size.width, height: item.frame.size.height)
            border.borderWidth = width
            
            item.layer.addSublayer(border)
            item.layer.masksToBounds = true
            
            // setup keyboard
            item.delegate = self
        }
    }
    
    // MARK: - Keyboard customization
    func addDoneButtonOnKeyboard()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.Default
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        var prev: UIBarButtonItem = UIBarButtonItem(title: "Prev", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("prevButtonAction"))
        var next: UIBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("nextButtonAction"))
        
        var items = NSMutableArray()
        items.addObject(prev)
        items.addObject(next)
        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = items as [AnyObject]
        doneToolbar.sizeToFit()
        
        bankCardNumberField.inputAccessoryView = doneToolbar
        cardHolderNameField.inputAccessoryView = doneToolbar
        expDateField.inputAccessoryView = doneToolbar
        cvvField.inputAccessoryView = doneToolbar
        
    }
    
    func prevButtonAction()
    {
        if bankCardNumberField.isFirstResponder() {  }
        if cardHolderNameField.isFirstResponder() { bankCardNumberField.becomeFirstResponder() }
        if expDateField.isFirstResponder() { cardHolderNameField.becomeFirstResponder() }
        if cvvField.isFirstResponder() { expDateField.becomeFirstResponder() }
    }
    
    func nextButtonAction()
    {
        if bankCardNumberField.isFirstResponder() { cardHolderNameField.becomeFirstResponder() }
        if cardHolderNameField.isFirstResponder() { expDateField.becomeFirstResponder() }
        if expDateField.isFirstResponder() { cvvField.becomeFirstResponder() }
        if cvvField.isFirstResponder() { }
    }
    
    func doneButtonAction()
    {
        if bankCardNumberField.isFirstResponder() { bankCardNumberField.resignFirstResponder() }
        if cardHolderNameField.isFirstResponder() { cardHolderNameField.resignFirstResponder() }
        if expDateField.isFirstResponder() { expDateField.resignFirstResponder() }
        if cvvField.isFirstResponder() { cvvField.resignFirstResponder() }
    }
    
    // MARK: - Functionalities
    
    // MARK: - Delegates
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField === bankCardNumberField {
            cardHolderNameField.becomeFirstResponder()
        } else if textField === cardHolderNameField {
            expDateField.becomeFirstResponder()
        } else if textField === expDateField {
            cvvField.becomeFirstResponder()
        } else if textField === cvvField {
            cvvField.resignFirstResponder()
        }
        return true
    }
    
    /*
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
    */
}

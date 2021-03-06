//
//  AddBankCardVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/25/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class AddBankCardVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {

    // just a label, I try to track color
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var visaImage: UIImageView!
    @IBOutlet weak var americanExpressImage: UIImageView!
    @IBOutlet weak var masterCardImage: UIImageView!
    @IBOutlet weak var discoverImage: UIImageView!
    @IBOutlet weak var jcbImage: UIImageView!
    
    @IBOutlet weak var bankCardNumberField: SHSPhoneTextField!
    //    @IBOutlet weak var bankCardNumberField: UITextField!
    @IBOutlet weak var cardHolderNameField: UITextField!
    @IBOutlet weak var expDateField: UITextField!
    @IBOutlet weak var cvvField: UITextField!
    
    // textFields convenience, for item in loop
    private var textFields = [UITextField]()
    
    // data source of pickerview, used for keyboard of exp date input
    private let pickerData = [
        ["January","February","March","April","May","June","July","August","September","October","November","December"],
        ["2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030"]
    ]
    
    // store the type of card
    private var cardType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UI Work
    
    func setupUI() {
        
        // uitoolbar above keyboard for done, next, prev functionalities
        self.addDoneButtonOnKeyboard()
        
        // focus on it, so when enter screen, keyboard pops up and editing
        bankCardNumberField.becomeFirstResponder()
        bankCardNumberField.formatter.setDefaultOutputPattern("####################")
        
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
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        navigationController?.navigationBar.topItem!.title = "";
        
    }
    
    // MARK: - Keyboard customization
    
    // add a ui tool bar above each keyboard, and done, next, prev button
    func addDoneButtonOnKeyboard()
    {
        var doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.Default
        
        var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var fixedSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        done.tintColor = bankCardNumberField.textColor
        var prev: UIBarButtonItem = UIBarButtonItem(title: "   ⇠   ", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("prevButtonAction"))
        prev.tintColor = bankCardNumberField.textColor
        var next: UIBarButtonItem = UIBarButtonItem(title: "   ⇢   ", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("nextButtonAction"))
        next.tintColor = bankCardNumberField.textColor
        
        var items = NSMutableArray()
        items.addObject(prev)
        items.addObject(fixedSpace)
        items.addObject(next)
        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = items as [AnyObject]
        doneToolbar.sizeToFit()
        doneToolbar.backgroundColor = UIColor.whiteColor()
        
        bankCardNumberField.inputAccessoryView = doneToolbar
        cardHolderNameField.inputAccessoryView = doneToolbar
        expDateField.inputAccessoryView = doneToolbar
        cvvField.inputAccessoryView = doneToolbar
    }
    
    
    func prevButtonAction()
    {
        if bankCardNumberField.isFirstResponder() {  }
        else if cardHolderNameField.isFirstResponder() { bankCardNumberField.becomeFirstResponder() }
        else if expDateField.isFirstResponder() { cardHolderNameField.becomeFirstResponder() }
        else if cvvField.isFirstResponder() { expDateField.becomeFirstResponder() }
    }
    
    func nextButtonAction()
    {
        if bankCardNumberField.isFirstResponder() { cardHolderNameField.becomeFirstResponder() }
        else if cardHolderNameField.isFirstResponder() { expDateField.becomeFirstResponder() }
        else if expDateField.isFirstResponder() { cvvField.becomeFirstResponder() }
        else if cvvField.isFirstResponder() { }
    }
    
    func doneButtonAction()
    {
        if bankCardNumberField.isFirstResponder() { bankCardNumberField.resignFirstResponder() }
        else if cardHolderNameField.isFirstResponder() { cardHolderNameField.resignFirstResponder() }
        else if expDateField.isFirstResponder() { expDateField.resignFirstResponder() }
        else if cvvField.isFirstResponder() { cvvField.resignFirstResponder() }
    }
    
    // when exp date is editing, show picker view (month year picker) instead of keyboard
    @IBAction func textFieldEditing(sender: AnyObject) {
        var datePickerView: UIPickerView = UIPickerView()
        datePickerView.delegate = self
        datePickerView.backgroundColor = UIColor.whiteColor()
        expDateField.inputView = datePickerView
    }
    
    // called by delegate, when selected in pickerview
    // update text in expDate field
    func updateExpDate(myPicker: UIPickerView) {
        let month = pickerData[0][myPicker.selectedRowInComponent(0)]
        let year = pickerData[1][myPicker.selectedRowInComponent(1)]
        expDateField.text = month + ", " + year
    }
    
    /*
    func datePickerValueChanged(sender: UIDatePicker) {
    var dateformatter = NSDateFormatter()
    dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
    expDateField.text = dateformatter.stringFromDate(sender.date)
    }
    */
    
    // MARK: - Functionalities
    
    // TODO: - Format input text in above fields
    
    /**
    Detect credit card type and dim or highlight card icons
    */
    @IBAction func checkCardType(sender: SHSPhoneTextField) {
        let type = detectCreditCardType(sender.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
        cardType = type
        switch type {
        case "Visa":
            visaImage.alpha = 1
            masterCardImage.alpha = 0.3
            americanExpressImage.alpha = 0.3
            discoverImage.alpha = 0.3
            jcbImage.alpha = 0.3
            sender.formatter.setDefaultOutputPattern("#### #### #### ####")
            sender.setFormattedText(sender.text)
        case "MasterCard":
            visaImage.alpha = 0.3
            masterCardImage.alpha = 1
            americanExpressImage.alpha = 0.3
            discoverImage.alpha = 0.3
            jcbImage.alpha = 0.3
            sender.formatter.setDefaultOutputPattern("#### #### #### ####")
            sender.setFormattedText(sender.text)
        case "American Express":
            visaImage.alpha = 0.3
            masterCardImage.alpha = 0.3
            americanExpressImage.alpha = 1
            discoverImage.alpha = 0.3
            jcbImage.alpha = 0.3
            sender.formatter.setDefaultOutputPattern("#### ###### #####")
            sender.setFormattedText(sender.text)
        case "Discover":
            visaImage.alpha = 0.3
            masterCardImage.alpha = 0.3
            americanExpressImage.alpha = 0.3
            discoverImage.alpha = 1
            jcbImage.alpha = 0.3
            sender.formatter.setDefaultOutputPattern("#### #### #### ####")
            sender.setFormattedText(sender.text)
        case "JCB":
            visaImage.alpha = 0.3
            masterCardImage.alpha = 0.3
            americanExpressImage.alpha = 0.3
            discoverImage.alpha = 0.3
            jcbImage.alpha = 1
            sender.formatter.setDefaultOutputPattern("#### #### #### ####")
            sender.setFormattedText(sender.text)
        case "Invalid":
            visaImage.alpha = 1
            masterCardImage.alpha = 1
            americanExpressImage.alpha = 1
            discoverImage.alpha = 1
            jcbImage.alpha = 1
            sender.formatter.setDefaultOutputPattern("####################")
            sender.setFormattedText(sender.text)
        default:
            return
        }
    }
    
    /**
        CVV should not exceed 3 digit, or 4 depending on card type
    */
    @IBAction func trimCVV(sender: UITextField) {
        switch cardType! {
        case "American Express":
            if count(sender.text) > 4 {
                sender.text = dropLast(sender.text)
            }
        default:
            if count(sender.text) > 3 {
                sender.text = dropLast(sender.text)
            }
        }
        
    }
    
    @IBAction func popView(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Delegates
    
    // UITextFiew
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
    
    // UIPickerView
    /*
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let attributedString = NSAttributedString(string: "\(pickerData[row][component])", attributes: [NSForegroundColorAttributeName : UIColor.redColor()])
    return attributedString
    }
    */
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateExpDate(pickerView)
    }


}

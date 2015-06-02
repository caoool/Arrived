//
//  NewOrderFVC.swift
//  Arrived
//
//  Created by Lu Cao on 6/2/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class NewOrderFVC: FormViewController {
    
    struct Static {
        static let phoneTag = "phone"
        static let addressTag = "address"
        
        static let dateTime = "dateTime"
        static let date = "date"
        static let time = "time"
        
        static let titleTag = "title"
        static let detailTag = "detail"

        static let priceTag = "price"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: "submit:")
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    /// MARK: Actions
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func submit(_: UIBarButtonItem!) {
        
        let message = self.form.formValues().description
        
        let alert: UIAlertView = UIAlertView(title: "Form output", message: message, delegate: nil, cancelButtonTitle: "OK")
        
        alert.show()
    }
    
    /// MARK: Private interface
    
    private func loadForm() {
        
        let form = FormDescriptor()
        
        form.title = "New Request"
        
        let section1 = FormSectionDescriptor()
        
        var row: FormRowDescriptor! = FormRowDescriptor(tag: Static.phoneTag, rowType: .Phone, title: "Phone")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. +14444444444", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        row = FormRowDescriptor(tag: Static.addressTag, rowType: .Password, title: "Address")
        row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Enter Address", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        section1.addRow(row)
        
        let section2 = FormSectionDescriptor()
        
        
        let section3 = FormSectionDescriptor()
        
        let section4 = FormSectionDescriptor()
        
        
        form.sections = [section1, section2, section3, section4]
        
        self.form = form
    }
}

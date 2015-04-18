//
//  AddPaymentInfoVC.swift
//  Arrived
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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func register(sender: UIButton) {
        var dict = NSDictionary()
        dict.setValue(user.phoneNumberId!, forKey: "phoneNumberId")
        dict.setValue(pinLabel.text, forKey:"pinCode")
        dict.setValue(nameLabel.text, forKey:"fullName")
        dict.setValue(cardLabel.text, forKey:"bankCardNumber")
        dict.setValue(expDateLabel.text, forKey:"expirationDate")
        dict.setValue(pin2Label.text, forKey:"cvv")
        
        let result = user.register(dict)
        if let isSuccess = result["isSuccess"] as? Bool {
            if isSuccess {
                self.performSegueWithIdentifier("newUserCreated", sender: self)
            } else {
                println(result["message"])
            }
        }
    }
}

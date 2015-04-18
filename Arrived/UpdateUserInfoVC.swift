//
//  updateUserInfoVC.swift
//  Arrived
//
//  Created by Lu Cao on 4/19/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class UpdateUserInfoVC: UIViewController {

    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var birth: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var status: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func update() {
        var dict = NSDictionary()
        dict.setValue(user.phoneNumberId!, forKey: "phoneNumberId")
        dict.setValue(nickname.text, forKey: "nickname")
        dict.setValue(sex.text, forKey: "sex")
        dict.setValue(birth.text, forKey: "birth")
        dict.setValue(city.text, forKey: "city")
        dict.setValue(address.text, forKey: "address")
        dict.setValue(email.text, forKey: "email")
        dict.setValue(status.text, forKey: "status")
        
        let result = user.updateUserInfo(dict)
        if let isSuccess = result["isSuccess"] as? Bool {
            if isSuccess {
                self.performSegueWithIdentifier("BackToLoggedIn", sender: self)
            } else {
                println(result["message"])
            }
        }
    }
    

}

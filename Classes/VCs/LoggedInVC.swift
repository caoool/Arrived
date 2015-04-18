//
//  LoggedInVC.swift
//  Arrived
//
//  Created by Lu Cao on 4/17/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class LoggedInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
    }
    

}

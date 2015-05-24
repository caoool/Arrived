//
//  UserMenuVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/24/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class UserMenuVC: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self.transitionManager
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        cancelButton.layer.cornerRadius = cancelButton.frame.height/2
    }
    
    @IBAction func unwindToMainViewController(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

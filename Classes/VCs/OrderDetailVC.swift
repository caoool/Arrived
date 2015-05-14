//
//  OrderDetailVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/11/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class OrderDetailVC: UIViewController {

    var toPass = [String:AnyObject]()
    
    @IBOutlet weak var price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        price.text = toPass["price"] as? String
    }

    @IBAction func interest(sender: AnyObject) {
        
    }
    
    
}

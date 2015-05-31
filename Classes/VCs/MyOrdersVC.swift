//
//  MyOrdersVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/31/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class MyOrdersVC: UIViewController {

    @IBOutlet weak var curretTab: UIButton!
    @IBOutlet weak var interestsTab: UIButton!
    @IBOutlet weak var allTab: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initScene()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        curretTab.roundCorners(.TopLeft | .BottomLeft, radius: 9)
        allTab.roundCorners(.TopRight | .BottomRight, radius: 9)
        
        curretTab.alpha = 0.65
        interestsTab.alpha = 0.65
        allTab.alpha = 0.65
    }
    
    func initScene() {
        
        // set color of current tab so its defautly enabled
        curretTab.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        curretTab.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
    }

    @IBAction func tabTapped(sender: UIButton) {
        println(sender.titleLabel!.text!)
        switch sender.titleLabel!.text! {
        case "Current":
            UIView.animateWithDuration(0.65, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.curretTab.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.curretTab.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
                self.interestsTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.interestsTab.backgroundColor = UIColor.whiteColor()
                self.allTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.allTab.backgroundColor = UIColor.whiteColor()
                }, completion: nil)
        case "Interests":
            UIView.animateWithDuration(0.65, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.curretTab.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.curretTab.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
                self.interestsTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.interestsTab.backgroundColor = UIColor.whiteColor()
                self.allTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.allTab.backgroundColor = UIColor.whiteColor()
                }, completion: nil)
        case "All":
            UIView.animateWithDuration(0.65, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.curretTab.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.curretTab.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
                self.interestsTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.interestsTab.backgroundColor = UIColor.whiteColor()
                self.allTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.allTab.backgroundColor = UIColor.whiteColor()
                }, completion: nil)
        default:
            break
        }
    }
    
    
    
    
    
}





















//
//  MyOrdersVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/31/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class MyOrdersVC: UIViewController {

    var testOrders = [Order]()
    var isInitiated = false
    
    @IBOutlet weak var bgBlurView: UIImageView!
    
    
    @IBOutlet weak var leftTab: UIButton!
    @IBOutlet weak var midTab: UIButton!
    @IBOutlet weak var rightTab: UIButton!
    
    @IBOutlet weak var leftView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initScene()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !isInitiated {
            isInitiated = !isInitiated
            
            // add blur background
            bgBlurView.image = UIImage(named: "my portrait")
            var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
            var blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = bgBlurView.bounds
            bgBlurView.addSubview(blurView)
            
            // set up tabs
            leftTab.roundCorners(.TopLeft | .BottomLeft, radius: 9)
            rightTab.roundCorners(.TopRight | .BottomRight, radius: 9)
            
            leftTab.alpha = 0.65
            midTab.alpha = 0.65
            rightTab.alpha = 0.65
        }
        
        
    }
    
    func initScene() {
        
        // set color of current tab so its defautly enabled
        leftTab.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        leftTab.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)

    }

    @IBAction func tabTapped(sender: UIButton) {
        switch sender.titleLabel!.text! {
        case "Requests":
            UIView.animateWithDuration(0.65, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.leftTab.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.leftTab.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
                self.midTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.midTab.backgroundColor = UIColor.whiteColor()
                self.rightTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.rightTab.backgroundColor = UIColor.whiteColor()
                self.leftView.alpha = 1
                }, completion: nil)
        case "Jobs":
            UIView.animateWithDuration(0.65, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.midTab.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.midTab.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
                self.leftTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.leftTab.backgroundColor = UIColor.whiteColor()
                self.rightTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.rightTab.backgroundColor = UIColor.whiteColor()
                self.leftView.alpha = 0
                }, completion: nil)
        case "All":
            UIView.animateWithDuration(0.65, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.rightTab.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.rightTab.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
                self.midTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.midTab.backgroundColor = UIColor.whiteColor()
                self.leftTab.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                self.leftTab.backgroundColor = UIColor.whiteColor()
                self.leftView.alpha = 0
                }, completion: nil)
        default:
            break
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "MyOrdersRequestsTable" {
//            var svc = segue.destinationViewController as! MyOrdersRequestsTVC
//            svc.toPass = testOrders
//        }
    }
    
}





















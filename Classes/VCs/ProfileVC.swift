//
//  ProfileVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/2/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import Foundation

class ProfileVC: UIViewController {
    
    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var portrait: UIImageView!
    
    @IBOutlet weak var readyButton: UIButton!
    
    @IBOutlet weak var likesIcon: UIImageView!
    @IBOutlet weak var tasksIcon: UIImageView!
    @IBOutlet weak var balanceIcon: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var balance: UICountingLabel!
    @IBOutlet weak var tasks: UICountingLabel!
    @IBOutlet weak var likes: UICountingLabel!
    
    private var blurView: UIView = UIView()
    
    private var readyForJobs: Bool = true {
        didSet {
            if readyForJobs {
                readyButton.setImage(UIImage(named: "status ok"), forState: .Normal)
                bounceView(readyButton)
            } else {
                readyButton.setImage(UIImage(named: "status no"), forState: .Normal)
                bounceView(readyButton)
            }
        }
    }
    
    private var isInitiated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        initScene()
    }
    
    override func viewDidLayoutSubviews() {
        
        if !isInitiated {
            isInitiated = true
            // set bg image and blur
            bg.image = UIImage(named: "my portrait")
            var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
            var blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = bg.bounds
            bg.addSubview(blurView)
            
            // draw border of circle image
            portrait.image = UIImage(named: "my portrait")
            roundedWithWhiteBorder(portrait, width: 5)
            roundedWithWhiteBorder(readyButton, width: 3)
            drawLineFromPoint(portrait.center, toPoint: readyButton.center, ofColor: UIColor.whiteColor(), inView: view)
            
            view.bringSubviewToFront(portrait)
            view.bringSubviewToFront(readyButton)
            
        }
        
    }
    
    func initScene() {
        countingNumbers()
        changeIconColors()
    }
    
    // MARK: - UI Works
    
    func countingNumbers() {
        balance.format = "%d"
        likes.format = "%d"
        tasks.format = "%d"
        
        let rand1: NSTimeInterval = NSTimeInterval(randRange(10, upper: 25)) / 10
        let rand2: NSTimeInterval = NSTimeInterval(randRange(10, upper: 25)) / 10
        let rand3: NSTimeInterval = NSTimeInterval(randRange(10, upper: 25)) / 10
        balance.countFromZeroTo(3500, withDuration: rand1)
        likes.countFromZeroTo(39, withDuration: rand2)
        tasks.countFromZeroTo(99, withDuration: rand3)
        
        var timer1 = NSTimer.scheduledTimerWithTimeInterval(rand1, target: self, selector: Selector("balanceBounce"), userInfo: nil, repeats: false)
        var timer2 = NSTimer.scheduledTimerWithTimeInterval(rand2, target: self, selector: Selector("likesBounce"), userInfo: nil, repeats: false)
        var timer3 = NSTimer.scheduledTimerWithTimeInterval(rand3, target: self, selector: Selector("tasksBounce"), userInfo: nil, repeats: false)
    }
    
    func balanceBounce() {
        bounceView(balanceIcon)
        balanceIcon.tintColor = UIColorFromHex(0x5B65FD, alpha: 0.5)
    }
    func likesBounce() {
        bounceView(likesIcon)
        likesIcon.tintColor = UIColorFromHex(0xFFA9AA, alpha: 0.5)
    }
    func tasksBounce() {
        bounceView(tasksIcon)
        tasksIcon.tintColor = UIColorFromHex(0xE6C4FF, alpha: 0.5)
    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    func changeIconColors() {
        balanceIcon.image = balanceIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        balanceIcon.tintColor = UIColorFromHex(0x9EA6AF, alpha: 0.3)
        likesIcon.image = likesIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        likesIcon.tintColor = UIColorFromHex(0x9EA6AF, alpha: 0.3)
        tasksIcon.image = tasksIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        tasksIcon.tintColor = UIColorFromHex(0x9EA6AF, alpha: 0.3)
    }
    
    func roundedWithWhiteBorder(myView: UIView, width: CGFloat) {
        myView.layer.borderWidth = width
        myView.layer.masksToBounds = true
        myView.layer.borderColor = UIColorFromHex(0xFFFFFF, alpha: 1).CGColor
        myView.layer.cornerRadius = myView.frame.height/2
        myView.clipsToBounds = true
    }
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        
        //design the path
        var path = UIBezierPath()
        path.moveToPoint(start)
        path.addLineToPoint(end)
        
        //design path in layer
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.lineWidth = 2
        
        view.layer.addSublayer(shapeLayer)
    }
    
    @IBAction func changeStatus(sender: UIButton) {
        if readyForJobs {
            readyForJobs = false
        } else {
            readyForJobs = true
        }
    }
    
    
}

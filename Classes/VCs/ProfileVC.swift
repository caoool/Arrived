//
//  ProfileVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/2/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var portrait: UIImageView!
    
    @IBOutlet weak var readyButton: UIButton!
    
    private var readyForJobs: Bool = true {
        didSet {
            if readyForJobs {
                readyButton.setImage(UIImage(named: "status ok"), forState: .Normal)
            } else {
                readyButton.setImage(UIImage(named: "status no"), forState: .Normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        initScene()
    }
    
    override func viewDidLayoutSubviews() {
        
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
    
    func initScene() {
        self.navigationController?.navigationBar.frame.origin.y -= 100
    }
    
    // MARK: - UI Works
    
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

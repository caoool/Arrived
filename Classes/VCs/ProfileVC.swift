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
        
//        initScene()
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
        portrait.layer.borderWidth = 5
        portrait.layer.masksToBounds = true
        portrait.layer.borderColor = UIColorFromHex(0xFFFFFF, alpha: 1).CGColor
        portrait.layer.cornerRadius = portrait.frame.height/2
        portrait.clipsToBounds = true
        view.bringSubviewToFront(portrait)
    }
    
    func initScene() {
        
    }
    
    @IBAction func changeStatus(sender: UIButton) {
        if readyForJobs {
            readyForJobs = false
        } else {
            readyForJobs = true
        }
    }
    
    
}

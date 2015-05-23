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
    
    @IBOutlet weak var balanceImage: UIImageView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var tasksImage: UIImageView!
    @IBOutlet weak var tasksLabel: UILabel!
    
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
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
        portrait.layer.borderWidth = 5
        portrait.layer.masksToBounds = true
        portrait.layer.borderColor = UIColorFromHex(0xFFFFFF, alpha: 1).CGColor
        portrait.layer.cornerRadius = portrait.frame.height/2
        portrait.clipsToBounds = true
    }
    
    func initScene() {
        
        
        portrait.image = UIImage(named: "my portrait")
        
        let balanceImageColored = balanceImage.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        balanceImage.image = balanceImageColored
        balanceImage.tintColor = UIColorFromHex(0x7474BF, alpha: 1)
        
        let tasksImageColored = tasksImage.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        tasksImage.image = tasksImageColored
        tasksImage.tintColor = UIColorFromHex(0xF09819, alpha: 1)
        
        let likesImageColored = likesImage.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        likesImage.image = likesImageColored
        likesImage.tintColor = UIColorFromHex(0xf857a6, alpha: 1)
        
    }
    
    
    
}

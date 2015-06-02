//
//  MyOrdersRequestViewDetailVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/31/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class MyOrdersRequestViewDetailVC: UIViewController, UIScrollViewDelegate {
    
    var toPass: Order?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // price view
    
    @IBOutlet weak var priceLabel: UICountingLabel!
    @IBOutlet weak var priceLabeBackgroundView: UIView!
    private var currentPrice: Double?
    
    private var interested = false
    @IBOutlet weak var mapButton: UIButton!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var midButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    // detail view
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var startLeftView: UILabel!
    
    @IBOutlet weak var titleLeftView: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLeftView: UILabel!
    
    // user view
    @IBOutlet weak var leftView: UIView!
    
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    // media view
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var mediaScrollView: UIScrollView!
    @IBOutlet weak var mediaPageControl: UIPageControl!
    
    private var testImageViews = [UIImageView]()
    
    private var textColor: UIColor?
    
    private var isInitiated = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollViewWidth: CGFloat = mediaScrollView.frame.width
        let scrollViewHeight: CGFloat = mediaScrollView.frame.height
        
        var imageView1 = UIImageView(image: UIImage(named: "image1.jpg"))
        imageView1.frame = CGRectMake(0, 30, scrollViewWidth, scrollViewHeight)
        var imageView2 = UIImageView(image: UIImage(named: "image2.jpg"))
        imageView2.frame = CGRectMake(scrollViewWidth, 30, scrollViewWidth, scrollViewHeight)
        var imageView3 = UIImageView(image: UIImage(named: "image3.jpg"))
        imageView3.frame = CGRectMake(scrollViewWidth*2, 30, scrollViewWidth, scrollViewHeight)
        testImageViews = [imageView1, imageView2, imageView3]
        
        for item in testImageViews {
            mediaScrollView.addSubview(item)
        }
        mediaScrollView.contentSize = CGSizeMake(scrollViewWidth * CGFloat(testImageViews.count), scrollViewHeight)
        mediaScrollView.delegate = self
        mediaPageControl.currentPage = 0
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        initScene()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !isInitiated {
            isInitiated = true
            var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
            var blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = backgroundImageView.bounds
            backgroundImageView.addSubview(blurView)
            
            priceLabeBackgroundView.layer.borderWidth = 1.5
            priceLabeBackgroundView.layer.borderColor = UIColor.whiteColor().CGColor
            priceLabeBackgroundView.layer.cornerRadius = priceLabeBackgroundView.layer.bounds.height/2
            var blurEffect2 = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            var blurView2 = UIVisualEffectView(effect: blurEffect2)
            blurView2.frame = priceLabeBackgroundView.bounds
            priceLabeBackgroundView.addSubview(blurView2)
            priceLabeBackgroundView.alpha = 0.15
            
            var timer1 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("priceBounce"), userInfo: nil, repeats: false)
            
            leftButton.roundCorners(.TopLeft | .BottomLeft, radius: 9)
            rightButton.roundCorners(.TopRight | .BottomRight, radius: 9)
            
            leftButton.alpha = 0.65
            midButton.alpha = 0.65
            rightButton.alpha = 0.65
            
            titleLeftView.layer.borderColor = UIColor.lightGrayColor().CGColor
            titleLeftView.layer.borderWidth = 0.65
            titleLeftView.layer.cornerRadius = 2
            
            detailLeftView.layer.borderColor = UIColor.lightGrayColor().CGColor
            detailLeftView.layer.borderWidth = 0.65
            detailLeftView.layer.cornerRadius = 2
            
            startLeftView.layer.borderColor = UIColor.lightGrayColor().CGColor
            startLeftView.layer.borderWidth = 0.65
            startLeftView.layer.cornerRadius = 2
            
            //            endLeftView.layer.borderColor = UIColor.lightGrayColor().CGColor
            //            endLeftView.layer.borderWidth = 0.65
            //            endLeftView.layer.cornerRadius = 2
            
            let newImage = mapButton.imageView?.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            mapButton.tintColor = UIColor(red:0.29, green:0.56, blue:0.89, alpha:0.5)
            mapButton.setImage(newImage, forState: .Normal)
            
            portraitImageView.layer.borderWidth = 1.5
            portraitImageView.layer.borderColor = UIColor.whiteColor().CGColor
            portraitImageView.layer.cornerRadius = 12
        }
    }
    
    func priceBounce() {
        bounceView(priceLabel)
    }
    
    func initScene() {
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        textColor = leftButton.titleLabel?.textColor
        midButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        midButton.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
        
        priceLabel.text = "$ \(toPass!.price!)"
        currentPrice = toPass!.price
        
        startTimeLabel.text = toPass!.effectiveStartDate
        //        endTimeLabel.text = toPass!.effectiveEndDate
        
        titleLabel.text = toPass!.title
        
        // user view
        leftView.alpha = 0
        
        portraitImageView.image = UIImage(named: "my portrait")
        nicknameLabel.text = toPass!.nickname
        statusLabel.text = "Come come people, you all need to buy my album"
        
        // media view
        rightView.alpha = 0
        
        
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        switch sender.titleLabel!.text! {
        case "User":
            UIView.animateWithDuration(0.65, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.leftButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.leftButton.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
                self.midButton.setTitleColor(self.textColor, forState: .Normal)
                self.midButton.backgroundColor = UIColor.whiteColor()
                self.rightButton.setTitleColor(self.textColor, forState: .Normal)
                self.rightButton.backgroundColor = UIColor.whiteColor()
                self.midView.alpha = 0
                self.leftView.alpha = 1
                self.rightView.alpha = 0
                }, completion: nil)
        case "Detail":
            UIView.animateWithDuration(0.65, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.midButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.midButton.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
                self.leftButton.setTitleColor(self.textColor, forState: .Normal)
                self.leftButton.backgroundColor = UIColor.whiteColor()
                self.rightButton.setTitleColor(self.textColor, forState: .Normal)
                self.rightButton.backgroundColor = UIColor.whiteColor()
                self.midView.alpha = 1
                self.leftView.alpha = 0
                self.rightView.alpha = 0
                }, completion: nil)
        case "Media":
            UIView.animateWithDuration(0.65, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.rightButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                self.rightButton.backgroundColor = UIColor(red:0.63, green:0.62, blue:0.89, alpha:1)
                self.midButton.setTitleColor(self.textColor, forState: .Normal)
                self.midButton.backgroundColor = UIColor.whiteColor()
                self.leftButton.setTitleColor(self.textColor, forState: .Normal)
                self.leftButton.backgroundColor = UIColor.whiteColor()
                self.midView.alpha = 0
                self.leftView.alpha = 0
                self.rightView.alpha = 1
                }, completion: nil)
        default:
            break
        }
    }
    
    @IBAction func addressButtonTapped(sender: UIButton) {
        bounceView(sender)
        let viewController = ContentViewController()
        viewController.toPass = toPass!.address!
        viewController.latitude = toPass!.latitude!
        viewController.longitude = toPass!.longitude!
        let alert = AlertController(view: viewController.view, style: .ActionSheet)
        showAlert(alert)
    }
    
    func showAlert(alert: SimpleAlert.Controller) {
        
        
        
        alert.addAction(SimpleAlert.Action(title: "Navigate", style: .Destructive) { action in
            })
        
        alert.addAction(SimpleAlert.Action(title: "OK", style: .OK) { action in
            })
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}





















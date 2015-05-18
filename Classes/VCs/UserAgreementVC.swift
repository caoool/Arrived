//
//  UserAgreementVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/16/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class UserAgreementVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var next: UIButton!
    
    private var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        next.enabled = false
        color = next.backgroundColor
        next.backgroundColor = UIColor.grayColor()
        setScrollerView()
    }
    
    func setScrollerView() {
        
        scroller.delegate = self
        
        var f = text.frame
        f.size.height = text.contentSize.height
        text.frame = f;
        scroller.contentSize = CGSizeMake(280, 10 + CGRectGetMaxY(f));
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var scrollViewHeight = scrollView.frame.size.height;
        var scrollContentSizeHeight = scrollView.contentSize.height;
        var scrollOffset = scrollView.contentOffset.y;
        
        if (scrollOffset == 0)
        {
            // at top
        }
        else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
        {
            // at bottom
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                () -> Void in
                self.next.backgroundColor = self.color
                }, completion: {
                    finished in
                    self.next.enabled = true
            })
        }
    }
    
}

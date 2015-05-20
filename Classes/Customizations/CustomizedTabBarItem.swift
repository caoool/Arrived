//
//  CustomizedTabBarItem.swift
//  Arrived
//
//  Created by Lu Cao on 5/19/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import Foundation

@IBDesignable class CustomizedTabBarItem: UITabBarItem {
    @IBInspectable var finalImage:UIImage = UIImage() {
        didSet {
            self.image = finalImage.imageWithRenderingMode(.AlwaysOriginal)
        }
    }
    @IBInspectable var finalSelectedImage:UIImage = UIImage() {
        didSet {
            self.selectedImage = finalSelectedImage.imageWithRenderingMode(.AlwaysOriginal)
        }
    }

}

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext() as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
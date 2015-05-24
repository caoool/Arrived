//
//  MainScreenVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/2/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class RecordedAudio: NSObject {
    var title: String?
    var filePathURL: String?
}

class MainScreenVC: UITabBarController, UITabBarDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    private var buttonImage: UIImage? = UIImage(named: "center button")
    private var buttonHightLightImage: UIImage?
    private var buttonSelectedImage: UIImage? = UIImage(named: "speak button")
    private var buttonSelectedHightlightImage: UIImage?
    
    private var button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    private var buttonShouldRotate: Bool = true {
        didSet {
            if buttonShouldRotate {
                rotateButton()
            } else {
                button.layer.removeAllAnimations()
                button.transform = CGAffineTransformIdentity
            }
        }
    }
    
    // audio related
    private var hasRecording = false
    private var soundPlayer : AVAudioPlayer?
    private var soundRecorder : AVAudioRecorder?
    private var session : AVAudioSession?
    private var soundPath : String?
    
    private var waveformView = SiriWaveformView()
    private var recordingView = UIView()
    
    private var centerButtonSelected: Bool? {
        didSet {
            if centerButtonSelected! {
                button.setBackgroundImage(buttonSelectedImage, forState: UIControlState.Normal)
                button.setBackgroundImage(buttonSelectedImage, forState: UIControlState.Highlighted)
            } else {
                button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
                button.setBackgroundImage(buttonImage, forState: UIControlState.Highlighted)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAudioRecorder()
        initWaveformView()
        initRecordingView()
        
        customizeColorOfBarItems()
        addCenterRaisedButton()
        addButtonLongPressGuesture()
    }
    
    func initAudioRecorder() {
        soundPath = "\(NSTemporaryDirectory())test.wav"
        
        let url = NSURL(fileURLWithPath: soundPath!)
        
        session = AVAudioSession.sharedInstance()
        session?.setActive(true, error: nil)
        
        var error : NSError?
        
        session?.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        
        soundRecorder = AVAudioRecorder(URL: url, settings: nil, error: &error)
        soundRecorder?.meteringEnabled = true
        
        if(error != nil)
        {
            println("Error initializing the recorder: \(error)")
        }
        
        soundRecorder?.delegate = self
        soundRecorder?.prepareToRecord()
    }
    
    func initWaveformView() {
        var displaylink = CADisplayLink(target: self, selector: "updateWaveform")
        displaylink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        
        waveformView.waveColor = tabBar.barTintColor!
        waveformView.primaryWaveLineWidth = 3.0
        waveformView.secondaryWaveLineWidth = 1.0
        
        waveformView.frame = self.view.frame
        waveformView.backgroundColor = UIColor.blackColor()
        waveformView.alpha = 0.75
    }
    
    func initRecordingView() {
        // add waveform to this subview
        recordingView.addSubview(waveformView)
        
        // add label to this subview
        var label = UILabel(frame: CGRectMake(0, 0, 300, 21))
        label.center.y = self.view.center.y - 65
        label.textColor = tabBar.barTintColor!
//        label.textAlignment = NSTextAlignment.Center
        label.text = "Release finger to finish recording"
        recordingView.addSubview(label)
        recordingView.bringSubviewToFront(label)
    }
    
    // MARK: - UI Works
    
    /**
        Customize color of bar item
    */
    func customizeColorOfBarItems() {
        for item in self.tabBar.items as! [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
            if let image = item.selectedImage {
                item.selectedImage = image.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
    }
    
    /**
        Add raised center button
    */
    func addCenterRaisedButton() {
        button.frame = CGRectMake(0.0, 0.0, buttonImage!.size.width, buttonImage!.size.height)
        button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        button.setBackgroundImage(buttonImage, forState: UIControlState.Highlighted)
        
        let heightDifference = buttonImage!.size.height - self.tabBar.frame.size.height
        if heightDifference < 0 {
            button.center = self.tabBar.center
        } else {
//            var center = self.tabBar.center
//            center.y -= heightDifference/2
//            button.center = center;
            
            var center = CGPointMake(self.tabBar.center.x, self.tabBar.center.y-self.tabBar.frame.size.height/2)
            button.center = center
        }
        
        button.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(button)
        buttonShouldRotate = true
    }
    
    func rotateButton() {

        UIView.animateWithDuration(0.05, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.CurveLinear, animations: {
            self.button.transform = CGAffineTransformRotate(self.button.transform, 0.01)
            }, completion: {
                finished in
                if self.buttonShouldRotate { self.rotateButton() }
                else { self.button.transform = CGAffineTransformIdentity }
        })
    }
    
    /**
        Update waveform when recording
    */
    func updateWaveform() {
        soundRecorder?.updateMeters()
        var normalizedValue = pow(10, soundRecorder!.averagePowerForChannel(0) / 20)
        waveformView.updateWithLevel(CGFloat(normalizedValue))
    }
    
    // MARK: - Functionalities
    
    func pressed(sender: UIButton!) {
        self.selectedIndex = 1
        centerButtonSelected = true
        buttonShouldRotate = false
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        centerButtonSelected = false
        if !buttonShouldRotate { buttonShouldRotate = true }
    }
    
    /** 
        Hold center button to speak
    */
    
    func addButtonLongPressGuesture() {
        var buttonLongPressGuesture = UILongPressGestureRecognizer(target: self, action: "handleButtonLongPressGuesture:")
        button.addGestureRecognizer(buttonLongPressGuesture)
    }
    
    func handleButtonLongPressGuesture(recognizer: UILongPressGestureRecognizer) {
        //as you hold the button this would fire
        if recognizer.state == UIGestureRecognizerState.Began {
            println("held")
            // TODO: - Start to record voice
            recordAudio()
        }
        
        // as you release the button this would fire
        if recognizer.state == UIGestureRecognizerState.Ended {
            println("up")
            // TODO: - Stop record voice
            stopRecording()
            playAudio()
        }
    }
    
    func recordAudio() {
        session?.requestRecordPermission(){
            granted in
            if(granted == true)
            {
                self.soundRecorder?.record()
                
                // add waveform view
                self.view.addSubview(self.recordingView)
                self.view.bringSubviewToFront(self.button)
            }
            else
            {
                println("Unable to record")
            }
        }
    }
    
    func stopRecording() {
        soundRecorder?.stop()
        
        // remove waveform view
        recordingView.removeFromSuperview()
        hasRecording = true
    }
    
    func playAudio() {
        let url = NSURL(fileURLWithPath: soundPath!)
        var error : NSError?
        
        soundPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        if(error == nil)
        {
            soundPlayer?.delegate = self
            soundPlayer?.play()
        }
        else
        {
            println("Error initializing player \(error)")
        }
        hasRecording = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}













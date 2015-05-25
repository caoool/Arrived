//
//  MakeOrderVC.swift
//  Arrived
//
//  Created by Yetian Mao on 5/9/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit

class MakeOrderVC: UIViewController {
    
    var audioRecorder : AudioRecorder = AudioRecorder()
    var audioPlayer : AudioPlayer = AudioPlayer()
    var audioManager : AudioManager = AudioManager()
    var name : NSString = "Recording"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startRecording(sender: AnyObject) {
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        name = dateFormatter.stringFromDate(now)
        self.audioRecorder.startRecording()
    }
    @IBAction func stopRecording(sender: AnyObject) {
        self.audioRecorder.stopRecordng()
    }
    @IBAction func playAudio(sender: AnyObject) {
        let path = audioManager.audioURLWithName(name)
        self.audioPlayer.playAudio(path)
    }
    @IBAction func stopAudio(sender: AnyObject) {
        self.audioPlayer.stopAudio()
    }
    
}

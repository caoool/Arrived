//
//  WaveformVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/21/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import AVFoundation

class WaveformVC: UIViewController {

    @IBOutlet weak var waveformView: SiriWaveformView!
    
    // audio related
    private var hasRecording = false
    var audioRecorder : AudioRecorder = AudioRecorder()
    var audioPlayer : AudioPlayer = AudioPlayer()
    var audioManager : AudioManager = AudioManager()
    var name : NSString = "Recording"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initAudioRecorder()
    }

    func initAudioRecorder() {
//        var url = NSURL(fileURLWithPath: "/dev/null")
//        
//        var error: NSError?
//        recorder = AVAudioRecorder(URL: url, settings: nil, error: &error)
//        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
//        
//        if error != nil {
//            println(error)
//        }
//        
//        recorder?.prepareToRecord()
//        recorder?.meteringEnabled = true
//        recorder?.record()
        
        var displaylink = CADisplayLink(target: self, selector: "updateWaveform")
        displaylink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        
        waveformView!.waveColor = UIColor.blueColor()
        waveformView!.primaryWaveLineWidth = 3.0
        waveformView!.secondaryWaveLineWidth = 1.0
    }
    
    /**
    Update waveform when recording
    */
    func updateWaveform() {
        audioRecorder.audioRecorder?.updateMeters()
        var normalizedValue = pow(10, audioRecorder.audioRecorder!.averagePowerForChannel(2) / 20)
        waveformView.updateWithLevel(CGFloat(normalizedValue))
    }

}

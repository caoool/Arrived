//
//  WaveformVC.swift
//  Arrived
//
//  Created by Lu Cao on 5/21/15.
//  Copyright (c) 2015 LoopCow. All rights reserved.
//

import UIKit
import AVFoundation

class WaveformVC: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var waveformView: SiriWaveformView!
    
    private var recorder: AVAudioRecorder?
    
    // audio related
    private var hasRecording = false
    private var soundPlayer : AVAudioPlayer?
    private var soundRecorder : AVAudioRecorder?
    private var session : AVAudioSession?
    private var soundPath : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
        session?.requestRecordPermission(){
            granted in
            if(granted == true)
            {
                self.soundRecorder?.record()
            }
            else
            {
                println("Unable to record")
            }
        }
        
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
        soundRecorder?.updateMeters()
        var normalizedValue = pow(10, soundRecorder!.averagePowerForChannel(0) / 20)
        waveformView?.updateWithLevel(CGFloat(normalizedValue))
    }

}

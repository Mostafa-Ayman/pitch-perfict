//
//  RecordSoundViewController.swift
//  FirstTest
//
//  Created by SAM on 10/3/18.
//  Copyright © 2018 SAM. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController , AVAudioRecorderDelegate{

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingBotton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingBotton.isEnabled = false
    }
       //override func viewWillAppear(_ animated: Bool) {
  //     super.viewWillAppear(animated)
    //}

    @IBAction func recordAudio(_ sender: AnyObject) {
        recordingLabel.text = "Recording in progress"
        stopRecordingBotton.isEnabled = true
        recordButton.isEnabled = false
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecrdingFunc(_ sender: Any) {
        stopRecordingBotton.isEnabled = false
        recordButton.isEnabled = true
        recordingLabel.text = "press to record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    //saving the record and flag == true if saved else false
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)}
        else{print ("Recording is not successful")}}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //first check if that the segue that we want
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! playSoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

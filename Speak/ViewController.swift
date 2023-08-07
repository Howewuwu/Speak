//
//  ViewController.swift
//  Speak
//
//  Created by Howe on 2023/7/25.
//

import UIKit
import AVFAudio

class ViewController: UIViewController {
    
    let synthesizer = AVSpeechSynthesizer()
    var rateValueInstance: Float = 0.5
    var pitchMultiplierInstance: Float = 1
    
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var inputTextfield: UITextField!
    @IBOutlet weak var rateValue: UISlider!
    @IBOutlet weak var pitchMultiplierSlider: UISlider!
    @IBOutlet weak var pitchMultiplierLabel: UILabel!
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        rateLabel.text = "0.50"
        pitchMultiplierLabel.text = "1.0"
        
    }
    
    
    
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
    @IBAction func rateValueAndpitchMultiplierChange(_ sender: UISlider) {
        rateValueInstance = rateValue.value
        rateLabel.text = String(format: "%.2f", rateValueInstance)
        pitchMultiplierInstance = pitchMultiplierSlider.value
        pitchMultiplierLabel.text = String(format: "%.2f", pitchMultiplierInstance)
    }
    
    
    
    
    @IBAction func speak(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: inputTextfield.text!)
        
        utterance.voice = AVSpeechSynthesisVoice(language:"zh-TW")
        utterance.rate = rateValueInstance
        utterance.pitchMultiplier = pitchMultiplierInstance
        synthesizer.speak(utterance)
        print("講完了")
    }
    
    
    
    
    
    @IBAction func languageChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: break
                
        case 1: break
                
            default:
                break
        }
        
    }
    
    
    
    let phrases: [String: (chinese: String, english: String)] = [
        "給我 TIME CODE": ("給我 TIME CODE", "Give me TIME CODE"),
        "檔號": ("檔號", "File Number"),
        "CUT": ("CUT", "CUT"),
        "手機請幫我關靜音": ("手機請幫我關靜音", "Please mute the phone for me"),
        "現場收音": ("現場收音", "On-site recording"),
        "這顆不錯，我們再一顆": ("這顆不錯，我們再一顆", "This one's good, let's do again"),
        "CAMARA": ("CAMARA", "CAMERA"),
        "今天要是沒拍完，也不會有明天了":("今天要是沒拍完，也不會有明天了", "If we don't finish filming today, there won't be a tomorrow.")
    ]

    
    
    
    @IBAction func wordBox(_ sender: UIButton) {
        var wordString: String = ""
            if let identifier = sender.restorationIdentifier, let phrase = phrases[identifier] {
                if languageSegmentedControl.selectedSegmentIndex == 0 {
                    wordString = phrase.chinese
                } else {
                    wordString = phrase.english
                }
            }

            let utterance = AVSpeechUtterance(string: wordString)
            if languageSegmentedControl.selectedSegmentIndex == 0 {
                utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
            } else {
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            }
            utterance.rate = rateValueInstance
            utterance.pitchMultiplier = pitchMultiplierInstance
            synthesizer.speak(utterance)

    }
    
}
        
        

//
//  ViewController.swift
//  Speak
//
//  Created by Howe on 2023/7/25.
//

import UIKit
import AVFAudio

class ViewController: UIViewController {
    
    let synthesizer = AVSpeechSynthesizer() // 建立一個語音合成器
    var rateValueInstance: Float = 0.5 // 語速
    var pitchMultiplierInstance: Float = 1 // 語調
    
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var inputTextfield: UITextField!
    @IBOutlet weak var rateValue: UISlider!
    @IBOutlet weak var pitchMultiplierSlider: UISlider!
    @IBOutlet weak var pitchMultiplierLabel: UILabel!
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 讓你點擊空白區域收起鍵盤
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        rateLabel.text = "0.50" // 初始速度
        pitchMultiplierLabel.text = "1.0" // 初始語調
    }
    
    
    
    
    // 點擊空白區域收起鍵盤的方法
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
    @IBAction func rateValueAndpitchMultiplierChange(_ sender: UISlider) {
        rateValueInstance = rateValue.value // 改變語速
        rateLabel.text = String(format: "%.2f", rateValueInstance)
        pitchMultiplierInstance = pitchMultiplierSlider.value // 改變語調
        pitchMultiplierLabel.text = String(format: "%.2f", pitchMultiplierInstance)
    }
    
    
    
    
    @IBAction func speak(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: inputTextfield.text!) // 讀取輸入文字
        utterance.voice = AVSpeechSynthesisVoice(language:"zh-TW") // 設定語言
        utterance.rate = rateValueInstance // 設定語速
        utterance.pitchMultiplier = pitchMultiplierInstance // 設定語調
        synthesizer.speak(utterance) // 讀出輸入文字
    }
    
    
    
    
    
    @IBAction func languageChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: break
        case 1: break
        default:
            break
        }
    }
    
    /*
     這組字典的結構略有不同，但它的核心概念仍然是一樣的。這裡，鍵 (key) 仍然是一個 String，但其對應的值 (value) 變成了一個元組 (tuple)。
     這個元組有兩個 String 元素：chinese 和 english。
     
     讓我逐步解釋：
     元組 (Tuple): 在 Swift中，元組是一種將多個值組合成單一複合值的方法。
     每個值都有其自己的類型和順序，而元組的整體也有其自己的類型，該類型是其元素的類型所組成的。
     在這裡，你的元組是 (chinese: String, english: String)。
     這表示這個元組有兩個 String 型態的元素，分別用 chinese 和 english 這兩個名稱來標識。
     這樣的字典結構允許你對於每個鍵，都存儲兩個相關但不同的值。這在當你需要查找一個鍵的多個相關值時非常有用。
     要訪問這種字典中的某個值，你可以這樣做：

     let selectedPhrase = phrases["檔號"]
     print(selectedPhrase?.chinese)  // 輸出: 檔號
     print(selectedPhrase?.english)  // 輸出: File Number
     在這裡，selectedPhrase 是一個元組，它有 chinese 和 english 這兩個元素，你可以透過它們來訪問各自的值。

     這種結構的好處是，當你想要查找一個鍵的多個相關值時，你不需要多次查詢字典或者使用多個字典。你只需要查找一次，然後使用元組中的相應元素即可。
     */
    
    let phrases: [String: (chinese: String, english: String)] = [
        "給我 TIME CODE": ("給我 TIME CODE", "Give me TIME CODE"),
        "檔號": ("檔號", "File Number"),
        "CUT": ("CUT", "CUT"),
        "手機請幫我關靜音": ("手機請幫我關靜音", "Please mute the phone for me"),
        "現場收音": ("現場收音", "On-site recording"),
        "這顆不錯，我們再一顆": ("這顆不錯，我們再一顆", "This one's good, let's do again"),
        "CAMARA": ("CAMARA", "CAMERA"),
        "今天要是沒拍完，也不會有明天了":("今天要是沒拍完，也不會有明天了", "")
    ]
    // 要讀出的中英文句子

    
    
    
    @IBAction func wordBox(_ sender: UIButton) {
        var wordString: String = ""
            if let identifier = sender.restorationIdentifier, let phrase = phrases[identifier] {
                if languageSegmentedControl.selectedSegmentIndex == 0 {
                    wordString = phrase.chinese // 若語言設定為中文，則讀中文句子
                } else {
                    wordString = phrase.english // 若語言設定為英文，則讀英文句子
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
        
        

//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    let eggTimes = ["Soft":3, "Medium":420, "Hard":720]
    var secondsRemaining:Int = 0
    var secondsPast = 0
    var totalTime = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
//        print(sender.currentTitle!)
//      changing the variables when a button is pressed
        let hardness = sender.currentTitle!
        timer.invalidate()
        titelLabel.text = hardness
        secondsPast = 0
        progressBar.progress = 0
        
//      Controlling the timer
        totalTime = eggTimes[hardness]!

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
//  Controling the timer
    @objc func updateTimer() {
        if secondsPast < totalTime {
            secondsPast += 1
            progressBar.progress = Float(secondsPast) / Float(totalTime)
            print(Float(secondsPast) / Float(totalTime))
        } else {
            timer.invalidate()
            titelLabel.text = "DONE!"
            playSound()
            
        }
    }
//  Playing Sound function
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}

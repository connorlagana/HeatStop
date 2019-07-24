//
//  TimerController.swift
//  HeatStop
//
//  Created by Connor Lagana on 7/18/19.
//  Copyright © 2019 Connor Lagana. All rights reserved.
//

import UIKit
import AVFoundation

class TimerController: UIViewController {
    
    var time: Int = 60
    var titleFood: String = ""
    var temp = ""
    
    var timer = Timer()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupUI()
    }
    
    let hoursLabel: UILabel = {
        let lbl = UILabel()
//        lbl.text = "0"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 48)
//        lbl.backgroundColor = .yellow
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let secondColonLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ":"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 48)
//        lbl.backgroundColor = .yellow
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let minutesLabel: UILabel = {
        let lbl = UILabel()
        //        lbl.text = "0"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 48)
//        lbl.backgroundColor = .yellow
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let colonLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ":"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 48)
//        lbl.backgroundColor = .yellow
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let secondsLabel: UILabel = {
        let lbl = UILabel()
        //        lbl.text = "0"
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 48)
//        lbl.backgroundColor = .yellow
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let startButton: UIButton = {
        let bttn = UIButton(type: .system)
        bttn.setTitle("Start", for: .normal)
        bttn.titleLabel?.font = .boldSystemFont(ofSize: 40)
        bttn.setTitleColor(.white, for: .normal)
        bttn.backgroundColor = .black
        bttn.addTarget(self, action: #selector(handleStartStop), for: .touchUpInside)
        bttn.layer.cornerRadius = 12
        bttn.translatesAutoresizingMaskIntoConstraints = false
        return bttn
    }()
    
    let uselessTextLabel: UITextView = {
        let lbl = UITextView()
        lbl.text = ""
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 48)
        lbl.textAlignment = .center
        //        lbl.backgroundColor = .yellow
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    @objc func handleStartStop() {
        
        
        if startButton.titleLabel?.text == "Start" {
            startButton.setTitle("Stop", for: .normal)
            startButton.backgroundColor = UIColor.init(red: 200/255, green: 0, blue: 0, alpha: 1)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleStart), userInfo: nil, repeats: true)
        }
        
        if startButton.titleLabel?.text == "Stop" {
            startButton.setTitle("Start", for: .normal)
            startButton.backgroundColor = .black
            timer.invalidate()
        }
        
        if startButton.titleLabel?.text == "Done" {
            startButton.setTitle("Start", for: .normal)
            startButton.backgroundColor = .black
            timer.invalidate()
        }
    }
    
    @objc func handleStart() {
        time -= 1
        let minutesRemaining = (time / 60) % 60
        let secondsRemaining = (time % 3600) % 60
        let hoursRemaining = ((time / 60) - minutesRemaining) / 60
        hoursLabel.text = String(hoursRemaining)
        minutesLabel.text = String(minutesRemaining)
        secondsLabel.text = String(secondsRemaining)
        
        if minutesRemaining < 10 {
            minutesLabel.text = "0\(minutesRemaining)"
        }
        
        if secondsRemaining < 10 {
            secondsLabel.text = "0\(secondsRemaining)"
        }
        
        if time == 0 {
            startButton.setTitle("Done", for: .normal)
            startButton.backgroundColor = .init(red: 0, green: 220/255, blue: 0, alpha: 1)
            timer.invalidate()
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playsound), userInfo: nil, repeats: true)
            
            uselessTextLabel.text = "Congrats! Your \(titleFood) are done! Pop those bad boys out the oven!"
        }
    }
    
    @objc func playsound() {
        let system: SystemSoundID = 1151
        AudioServicesPlayAlertSound(system)
    }
    
    func setupUI() {
        navigationItem.title = titleFood
        
        uselessTextLabel.text = "Heat your \(titleFood) at \(temp)°"
        
        let minutesRemaining = (time / 60) % 60
        let secondsRemaining = 00
        let hoursRemaining = ((time / 60) - minutesRemaining) / 60
        
        hoursLabel.text = String(hoursRemaining)
        minutesLabel.text = String(minutesRemaining)
        secondsLabel.text = String(secondsRemaining)
        
        
        view.addSubview(hoursLabel)
        view.addSubview(colonLabel)
        view.addSubview(minutesLabel)
        view.addSubview(secondColonLabel)
        view.addSubview(secondsLabel)
        view.addSubview(startButton)
        view.addSubview(uselessTextLabel)
        
        minutesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        minutesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        minutesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 14).isActive = true
        
        colonLabel.rightAnchor.constraint(equalTo: minutesLabel.leftAnchor).isActive = true
//        colonLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        colonLabel.topAnchor.constraint(equalTo: minutesLabel.topAnchor).isActive = true
        
        hoursLabel.rightAnchor.constraint(equalTo: colonLabel.leftAnchor).isActive = true
//        hoursLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        hoursLabel.topAnchor.constraint(equalTo: minutesLabel.topAnchor).isActive = true
        
        secondColonLabel.leftAnchor.constraint(equalTo: minutesLabel.rightAnchor).isActive = true
//        secondColonLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        secondColonLabel.topAnchor.constraint(equalTo: minutesLabel.topAnchor).isActive = true
        
        secondsLabel.leftAnchor.constraint(equalTo: secondColonLabel.rightAnchor).isActive = true
//        secondsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        secondsLabel.topAnchor.constraint(equalTo: minutesLabel.topAnchor).isActive = true
        
        startButton.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor, constant: 30).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        uselessTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        uselessTextLabel.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 14).isActive = true
        uselessTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        uselessTextLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -14).isActive = true
        
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }


}


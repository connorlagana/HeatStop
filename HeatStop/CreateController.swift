//
//  CreateController.swift
//  HeatStop
//
//  Created by Connor Lagana on 7/19/19.
//  Copyright © 2019 Connor Lagana. All rights reserved.
//

import UIKit
import CoreData

// Custom Delegation

protocol CreateControllerDelegate {
    func didAddFood(food: Food)
}

class CreateController: UIViewController {
    var delegate: CreateControllerDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "Temperature"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tempTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter temperature"
        textField.keyboardType = UIKeyboardType.numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let timePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = UIDatePicker.Mode.countDownTimer
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    @objc private func handleSave() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context)
        
        guard let name = self.nameTextField.text else { return }
        guard let temp = self.tempTextField.text else { return }
        let convertTemp = Int(temp)
        let time = self.timePicker.countDownDuration
        
        food.setValue(name, forKey: "name")
        food.setValue(convertTemp, forKey: "temp")
        food.setValue(time, forKey: "time")
        
        
        
        // perform the save
        do {
            try context.save()
            
            // success
            dismiss(animated: true, completion: {
                self.delegate?.didAddFood(food: food as! Food)
            })
            
        } catch let saveErr {
            print("Failed to save Food:", saveErr)
        }
        
        
        
//        dismiss(animated: true) {
//            guard let name = self.nameTextField.text else { return }
//            guard let temp = self.tempTextField.text else { return }
//            let convertTemp = Int(temp)
//            let time = self.timePicker.countDownDuration
//            
//            let food = Food(name: name, temp: convertTemp!, time: time)
//            
//            self.delegate?.didAddFood(food: food)
//        }
    }
    
    private func setupUI() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.customIndigo
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(timePicker)
        view.addSubview(tempLabel)
        view.addSubview(tempTextField)
        
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 102).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 4).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        tempLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        tempLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        tempLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tempTextField.leftAnchor.constraint(equalTo: tempLabel.rightAnchor, constant: 4).isActive = true
        tempTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tempTextField.bottomAnchor.constraint(equalTo: tempLabel.bottomAnchor).isActive = true
        tempTextField.topAnchor.constraint(equalTo: tempLabel.topAnchor).isActive = true
        
        timePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        timePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true
        timePicker.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 20).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationItem.title = "Create Food"
        view.backgroundColor = UIColor.customBlue
        
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}

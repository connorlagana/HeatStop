//
//  HomeView.swift
//  HeatStop
//
//  Created by Connor Lagana on 7/19/19.
//  Copyright © 2019 Connor Lagana. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UITableViewController, CreateControllerDelegate {
    
    let cellId = "ConnorLagana.HeatStop"
    var foods = [Food]()
    
    func didAddFood(food: Food) {
        foods.append(food)
        let newIndexPath = IndexPath(row: foods.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    private func fetchFoods() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Food>(entityName: "Food")
        
        do {
            let foods = try context.fetch(fetchRequest)
            
            foods.forEach({ (food) in
                print(food.name ?? "")
            })
            
            self.foods = foods
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch foods:", fetchErr)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFoods()
        
        view.backgroundColor = .customBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Your Foods"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(handleAddFood))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEdit))
    }
    
    @objc func handleAddFood() {
        let createController = CreateController()
        
        let navCont = CustomNavController(rootViewController: createController)
        
        createController.delegate = self
        
        present(navCont, animated: true, completion: nil)
    }
    
    @objc func handleEdit() {
        print("handling edit")
    }
    
    func secondsToHoursMinutes (seconds : Int) -> (Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = .customRed
        
        let food = foods[indexPath.row]
        let intTime = Int(food.time)
        let (hours,minutes) = secondsToHoursMinutes(seconds: intTime)
        if minutes < 10 {
            cell.textLabel?.text = "\(food.name!) - \(food.temp)° - \(hours):0\(minutes)"
        }
        
        else {
            cell.textLabel?.text = "\(food.name!) - \(food.temp)° - \(hours):\(minutes)"
        }
        
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let timerCont = TimerController()
        
        let time = foods[indexPath.row].time
        let name = foods[indexPath.row].name
        let temp = String(foods[indexPath.row].temp)
        let intTime = Int(time)
        
        timerCont.time = intTime
        timerCont.titleFood = name ?? ""
        timerCont.temp = temp
        
        
        navigationController?.pushViewController(timerCont, animated: true)
        
        
    }
}

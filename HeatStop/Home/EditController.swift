//
//  EditController.swift
//  HeatStop
//
//  Created by Connor Lagana on 7/20/19.
//  Copyright © 2019 Connor Lagana. All rights reserved.
//

import UIKit

class EditController: UIViewController {
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        view.backgroundColor = .customYellow
        
        navigationItem.title = name
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "timer"), style: .plain, target: self, action: #selector(handleTimer))
    }
    
    @objc func handleTimer() {
        navigationController?.pushViewController(TimerController(), animated: true)
    }
}

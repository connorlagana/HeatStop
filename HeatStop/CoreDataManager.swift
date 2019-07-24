//
//  CoreDataManager.swift
//  HeatStop
//
//  Created by Connor Lagana on 7/22/19.
//  Copyright © 2019 Connor Lagana. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager() // will live forever as long as your application is still alive, it's properties will too
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HeatStopModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
}

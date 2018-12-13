//
//  Manager.swift
//  carWash
//
//  Created by Student on 13.11.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Manager<ProcessingObject: MoneyGiver & Stateable>: Employee<ProcessingObject> {
    
    override func doWork(with processingObject: ProcessingObject) {
        self.receiveMoney(from: processingObject)
    }
    
    override func finishProcessing(object: ProcessingObject) {
        object.state = .available
    }
}

//
//  Washer.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Washer: Employee<Car> {

    override func doWork(with car: ProcessingObject) {
        car.state = .clean
    }
    
    override func finishProcessing(object: ProcessingObject) {
        self.receiveMoney(from: object)
    }
    
    override func finishWork() {
        self.state = .pendingProcessing
        print("Washer \(self.name) finish work")
    }
}

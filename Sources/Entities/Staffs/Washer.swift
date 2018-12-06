//
//  Washer.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Washer: Staff<Car> {

    override func doWork(with car: Car) {
        car.state = .clean
    }
    
    override func finishProcessing(object: Car) {
        self.receiveMoney(from: object)
    }
    
    override func finishWork() {
        self.state = .pendingProcessing
        print("Washer \(self.name) finish work")
    }
}

//
//  Director.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Director: Manager<Accountant> {

    override func doWork(with processingObject: Accountant) {
        self.receiveMoney(from: processingObject)
    }

    override func finishWork() {
        self.state = .available
        print("Director have \(self.money)")
    }
}

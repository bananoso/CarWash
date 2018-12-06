//
//  Accountant.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Accountant: Manager<Washer> {
    
    override func finishWork() {
        self.state = .pendingProcessing
        print("Accountant finish work and have \(self.money)")
    }
}

//
//  Car.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Car: MoneyGiver {
    
    enum State {
        case dirty
        case clean
    }
    
    var state: State {
        get { return self.atomicState.value }
        set { self.atomicState.value = newValue }
    }
    
    public var money: Int {
        return self.atomicMoney.value
    }
    
    private let atomicState = Atomic(State.dirty)
    private let atomicMoney: Atomic<Int>
    
    init(money: Int) {
        self.atomicMoney = Atomic(money)
    }
    
    // MoneyGiver members
    func giveMoney() -> Int {
        return self.atomicMoney.modify { money in
            defer { money = 0 }

            return money
        }
    }
}

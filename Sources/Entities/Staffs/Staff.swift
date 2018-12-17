//
//  Staff.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Staff: ObservableObject<Staff.State>, MoneyReceiver, MoneyGiver, Stateable {
    
    typealias StatePair = (old: State, new: State)
    
    enum State {
        case available
        case pendingProcessing
        case busy
    }
    
    public var money: Int {
        return self.atomicMoney.value
    }
    
    public var state: State {
        get { return self.atomicState.value }
        set { self.atomicState.value = newValue }
    }
    
    let name: String
    
    private(set) var atomicState: Atomic<State>!
    
    private let atomicMoney = Atomic(0)
    
    init(name: String) {
        self.name = name
        super.init()
        self.atomicState = Atomic(.available, didSet: self.didSet)
    }
    
    open func stateDidSet(_ state: StatePair) {
        self.observers.notify(property: state.new)
    }
    
    // MoneyReceiver members
    func receive(money: Int) {
        self.atomicMoney.modify { $0 += money }
    }
    
    // MoneyGiver members
    func giveMoney() -> Int {
        return self.atomicMoney.modify { money in
            defer { money = 0 }
            
            return money
        }
    }
    
    private func didSet(_ state: StatePair) {
        let (old, new) = state
        guard old != new else { return }
        
        self.stateDidSet(state)
    }
}

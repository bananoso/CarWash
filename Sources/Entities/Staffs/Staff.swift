//
//  Staff.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Staff: MoneyReceiver, MoneyGiver, Stateable {
    
    typealias DidSetHandler = ((old: State, new: State))-> ()
    
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
    
    private let stateObservers = ObserverCollection<State>()
    private let atomicMoney = Atomic(0)
    
    init(name: String) {
        self.name = name
        self.atomicState = Atomic(.available, didSet: self.didSet)
    }
    
    open func stateDidSet(_ stateTuple: (old: State, new: State)) {
        self.stateObservers.notify(value: stateTuple.new)
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
    
    func observer(handler: @escaping F.EventHandler<State>) -> Observer<State> {
        let observer = Observer(sender: self, handler: handler)
        self.stateObservers.add(observer)
        observer.handler(self.state)
    
        return observer
    }
    
    private func didSet(_ stateTuple: (old: State, new: State)) {
        let (old, new) = stateTuple
        guard old != new else { return }
        
        self.stateDidSet(stateTuple)
    }
}

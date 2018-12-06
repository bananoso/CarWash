//
//  Staff.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Staff<ProcessingObject: MoneyGiver>: MoneyReceiver, MoneyGiver, Stateable, Observable {
    
    enum Event: String {
        case onBusy
        case onAvailable
        case onPendingProcessing
    }
    
    enum State {
        case available
        case pendingProcessing
        case busy
    }
    
    public var state: State {
        get { return self.atomicState.value }
        set { self.atomicState.value = newValue }
    }
    
    public var money: Int {
        return self.atomicMoney.value
    }
    
    private var atomicState: Atomic<State>!
    
    let name: String
    
    private let rangeDuration = 0.1...1.0
    private let atomicMoney = Atomic(0)
    private let processingObjects = Queue<ProcessingObject>()
    private let dispatchQueue: DispatchQueue
    
    private let busyObservers = ObserverCollection()
    private let availableObservers = ObserverCollection()
    private let pendingProcessingObservers = ObserverCollection()
    
    init(name: String, dispatchQueue: DispatchQueue = .background) {
        self.name = name
        self.dispatchQueue = dispatchQueue
        
        self.atomicState = Atomic(State.available, didSet: self.didSetState)
    }
    
    open func doWork(with processingObject: ProcessingObject) {
        
    }
    
    open func finishProcessing(object: ProcessingObject) {
        
    }
    
    open func finishWork() {

    }
    
    func asyncDoWork(with object: ProcessingObject) {
        self.atomicState.modify {
            if $0 == .available {
                $0 = .busy
                self.process(object: object)
            } else {
                self.processingObjects.enqueue(object)
            }
        }
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
    
    // Observable members
    func addObserver(_ observer: Observer, event: String, handler: @escaping F.EventHandler) {
        self.executeFor(event: event) {
            $0.add(observer: observer, handler: handler)
        }
    }
    
    func removeObserver(_ observer: Observer, event: String) {
        self.executeFor(event: event) {
            $0.remove(observer: observer)
        }
    }
    
    private func executeFor(event: String, _ execute: (ObserverCollection) -> ()) {
        Event(rawValue: event).do {
            switch $0 {
            case .onBusy:
                execute(self.busyObservers)
            case .onAvailable:
                execute(self.availableObservers)
            case .onPendingProcessing:
                execute(self.pendingProcessingObservers)
            }
        }
    }
    
    private func process(object: ProcessingObject) {
        self.dispatchQueue.asyncAfter(deadline: .after(interval: .random(in: self.rangeDuration))) {
            self.doWork(with: object)
            self.finishProcessing(object: object)
            
            self.nextProcessingObject()
                .map(self.process)
                .or(self.finishWork)
        }
    }
    
    private func didSetState(old: State, new: State) {
        guard old != new else { return }
        
        switch new {
        case .available:
            self.nextProcessingObject()
                .map(self.asyncDoWork)
                .or { self.availableObservers.notifyAll(from: self) }
        case .pendingProcessing:
            self.pendingProcessingObservers.notifyAll(from: self)
        case .busy:
            self.busyObservers.notifyAll(from: self)
        }
    }
    
    private func nextProcessingObject() -> ProcessingObject? {
        return self.processingObjects.dequeue()
    }
}

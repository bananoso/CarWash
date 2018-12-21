//
//  Employee.swift
//  CarWashProject
//
//  Created by Student on 13.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Employee<ProcessingObject: MoneyGiver>: Staff, Processable {
    
    private let rangeDuration = 0.1...1.0
    private let processingObjects = Queue<ProcessingObject>()
    private let dispatchQueue: DispatchQueue
    
    init(name: String, dispatchQueue: DispatchQueue = .background) {
        self.dispatchQueue = dispatchQueue
        super.init(name: name)
    }
    
    override func stateDidSet(_ state: StatePair) {
        if state.new == .available {
            self.processingObjects.dequeue()
                .map(self.process)
                .ifNil { super.stateDidSet(state) }
        } else {
            super.stateDidSet(state)
        }
    }
    
    open func doWork(with processingObject: ProcessingObject) {
        
    }
    
    open func finishProcessing(object: ProcessingObject) {
        
    }
    
    open func finishWork() {
        self.state = .pendingProcessing
    }
    
    func process(object: ProcessingObject) {
        self.atomicState.modify {
            $0 = .busy
            self.dispatchQueue.asyncAfter(deadline: .after(interval: .random(in: self.rangeDuration))) {
                self.doWork(with: object)
                self.finishProcessing(object: object)
                self.finishWork()
            }
        }
    }
}

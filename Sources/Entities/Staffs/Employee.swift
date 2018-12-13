//
//  Employee.swift
//  CarWashProject
//
//  Created by Student on 13.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Employee<ProcessingObject: MoneyGiver>: Staff {
    
    private let rangeDuration = 0.1...1.0
    private let processingObjects = Queue<ProcessingObject>()
    private let dispatchQueue: DispatchQueue
    
    init(name: String, dispatchQueue: DispatchQueue = .background) {
        self.dispatchQueue = dispatchQueue
        super.init(name: name)
    }
    
    override func stateDidSet(_ stateTuple: (old: Staff.State, new: Staff.State)) {
        if stateTuple.new == .available {
            self.processingObjects.dequeue()
                .map(self.asyncDoWork)
                .ifNil { super.stateDidSet(stateTuple) }
        } else {
            super.stateDidSet(stateTuple)
        }
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
    
    private func process(object: ProcessingObject) {
        self.dispatchQueue.asyncAfter(deadline: .after(interval: .random(in: self.rangeDuration))) {
            self.doWork(with: object)
            self.finishProcessing(object: object)
            
            self.nextProcessingObject()
                .map(self.process)
                .ifNil(self.finishWork)
        }
    }
    
    private func nextProcessingObject() -> ProcessingObject? {
        return self.processingObjects.dequeue()
    }
}

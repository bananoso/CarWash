//
//  EmployeeManager.swift
//  CarWashProject
//
//  Created by Student on 19.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class EmployeeManager<ProcessableObject, ProcessingObject> {
    
    private let processableObjects = [ProcessableObject]()
    private let processingObjects = Queue<ProcessingObject>()
    
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
    
//    self.nextProcessingObject()
//    .map(self.process)
//    .ifNil(self.finishWork)
    
    private func nextProcessingObject() -> ProcessingObject? {
        return self.processingObjects.dequeue()
    }
}

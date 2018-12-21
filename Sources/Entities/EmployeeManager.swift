//
//  EmployeeManager.swift
//  CarWashProject
//
//  Created by Student on 19.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class EmployeeManager<ProcessableObject: Employee<ProcessingObject>, ProcessingObject: MoneyGiver>:
    ObservableObject<ProcessableObject> {
    
    private var observers = [ProcessableObject.Observer]()
    
    private let processableObjects: Atomic<[ProcessableObject]>
    private let processingObjects = Queue<ProcessingObject>()
    
    init(_ processableObjects: [ProcessableObject]) {
        self.processableObjects = Atomic(processableObjects)
        super.init()
        self.signObservers()
    }
    
    func asyncDoWork(with object: ProcessingObject) {
        self.processableObjects.transform {
            $0.first { $0.state == .available }
                .map { processableObject in
                    let processingObject = self.processingObjects.dequeue() ?? object
                    processableObject.process(object: processingObject)
                }
                .ifNil { self.processingObjects.enqueue(object) }
        }
    }
    
    func signObservers() {
        self.observers += self.processableObjects.value.map { object in
            let observer = object.observer { [weak self, weak object] in
                switch $0 {
                case .available: self?.processingObjects.dequeue().apply(object?.process)
                case .pendingProcessing: object.apply(self?.notify)
                case .busy: return
                }
            }
            
            return observer
        }
    }
}

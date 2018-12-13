//
//  ObserverCollection.swift
//  CarWashProject
//
//  Created by Student on 05.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class ObserverCollection<Value> {
    
    private let observers = Atomic([Observer<Value>]())
    
    func add(_ observer: Observer<Value>) {
        self.observers.modify { $0.append(observer) }
    }
    
    func notify(value: Value) {
        self.observers.modify {
            $0 = $0.filter { $0.isObserving }
            $0.forEach { $0.handler(value) }
        }
    }
    
    func forEach(_ body: (Observer<Value>) -> ()) {
        self.observers.transform {
            $0.forEach(body)
        }
    }
}

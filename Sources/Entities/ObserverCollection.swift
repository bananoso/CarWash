//
//  ObserverCollection.swift
//  CarWashProject
//
//  Created by Student on 05.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class ObserverCollection {
    
    private typealias ObserverHandler = (observer: Observer, handler: F.EventHandler)
    
    private var observers = [Int : ObserverHandler]()
    
    func add(observer: Observer, handler: @escaping F.EventHandler) {
        self.observers.updateValue((observer, handler), forKey: observer.id)
    }
    
    func remove(observer: Observer) {
        self.observers.removeValue(forKey: observer.id)
    }
    
    func notifyAll(from sender: Any) {
        self.observers.values.forEach { $0.handler(sender) }
    }
}

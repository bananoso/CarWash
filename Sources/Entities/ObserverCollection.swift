//
//  ObserverCollection.swift
//  CarWashProject
//
//  Created by Student on 05.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class WeakObserverCollection {
    
    private typealias ObserverHandler = (observer: WeakObserver, handler: F.EventHandler)
    
    private var observers = [Int : ObserverHandler]()
    
    private struct WeakObserver {
        weak var value: Observer?
    }
    
    func add(observer: Observer, handler: @escaping F.EventHandler) {
        let weakObserverHandler = (WeakObserver(value: observer), handler)
        self.observers.updateValue(weakObserverHandler, forKey: observer.id)
    }
    
    func remove(observer: Observer) {
        self.observers.removeValue(forKey: observer.id)
    }
    
    func notifyAll(from sender: Observable) {
        self.observers.forEach { key, observerHandler in
            observerHandler.observer.value
                .map {_ in observerHandler.handler(sender) }
                .or { self.observers.removeValue(forKey: key) }
        }
    }
}

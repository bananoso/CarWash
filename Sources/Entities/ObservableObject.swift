//
//  ObservableObject.swift
//  CarWashProject
//
//  Created by Student on 14.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class ObservableObject<Property> {
    
    typealias Handler = (Property) -> ()
    
    let observers = Observers()
    
    func observer(property: Property, handler: @escaping Handler) -> Observer {
        let observer = Observer(sender: self, handler: handler)
        self.observers.add(observer)
        observer.handler(property)
        
        return observer
    }
}

extension ObservableObject {
    
    class Observer: Hashable {
        
        public var isObserving: Bool {
            return self.sender != nil
        }
        
        public var hashValue: Int {
            return ObjectIdentifier(self).hashValue
        }
        
        weak private(set) var sender: AnyObject?
        let handler: Handler
        
        init(sender: AnyObject, handler: @escaping Handler) {
            self.sender = sender
            self.handler = handler
        }
        
        func cancel() {
            self.sender = nil
        }
        
        static func == (lhs: Observer, rhs: Observer) -> Bool {
            return lhs === rhs
        }
    }
    
    class Observers {
        
        private let observers = Atomic([Observer]())
        
        func add(_ observer: Observer) {
            self.observers.modify { $0.append(observer) }
        }
        
        func notify(value: Value) {
            self.observers.modify {
                $0 = $0.filter { $0.isObserving }
                $0.forEach { $0.handler(value) }
            }
        }
    }
}

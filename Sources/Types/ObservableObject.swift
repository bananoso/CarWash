//
//  ObservableObject.swift
//  CarWashProject
//
//  Created by Student on 14.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class ObservableObject<Property> {
    
    public typealias Handler = (Property) -> ()
    
    private let observers = Observers()
    
    public func observer(handler: @escaping Handler) -> Observer {
        let observer = Observer(sender: self, handler: handler)
        self.observers.add(observer)
        
        return observer
    }
    
    public func notify(property: Property) {
        self.observers.notify(property: property)
    }
}

extension ObservableObject {
    
    public class Observers {
        
        private let observers = Atomic([Observer]())
        
        public func add(_ observer: Observer) {
            self.observers.modify { $0.append(observer) }
        }
        
        fileprivate func notify(property: Property) {
            self.observers.modify {
                $0 = $0.filter { $0.isObserving }
                $0.forEach { $0.handler(property) }
            }
        }
        
        static func += (lhs: Observers, rhs: Observers) {
            lhs.observers.modify { $0 += rhs.observers.value }
        }
    }
}

//
//  ObservableObject+Observers.swift
//  CarWashProject
//
//  Created by Student on 14.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension ObservableObject {
    
    public class Observers {
        
        private let observers = Atomic([Observer]())
        
        public func add(_ observer: Observer) {
            self.observers.modify { $0.append(observer) }
        }
        
        public func notify(property: Property) {
            self.observers.modify {
                $0 = $0.filter { $0.isObserving }
                $0.forEach { $0.handler(property) }
            }
        }
    }
}

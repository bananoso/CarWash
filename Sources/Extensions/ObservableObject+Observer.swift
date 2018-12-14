//
//  ObservableObject+Observer.swift
//  CarWashProject
//
//  Created by Student on 14.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

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
}

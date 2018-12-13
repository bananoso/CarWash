//
//  Observer.swift
//  CarWashProject
//
//  Created by Student on 12.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Observer<Value>: Hashable {

    public var isObserving: Bool {
        return self.sender != nil
    }
    
    public var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
    
    weak private(set) var sender: AnyObject?
    let handler: F.EventHandler<Value>
    
    init(sender: AnyObject, handler: @escaping F.EventHandler<Value>) {
        self.sender = sender
        self.handler = handler
    }
    
    func cancel() {
        self.sender = nil
    }
    
    static func == (lhs: Observer<Value>, rhs: Observer<Value>) -> Bool {
        return lhs === rhs
    }
}

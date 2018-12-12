//
//  Observer.swift
//  CarWashProject
//
//  Created by Student on 12.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Observer<Value> {
    
    public var isObserving: Bool {
        return self.sender != nil
    }
    
    weak var sender: AnyObject?
    let handler: F.EventHandler<Value>
    
    init(sender: AnyObject, handler: @escaping F.EventHandler<Value>) {
        self.sender = sender
        self.handler = handler
    }
    
    func cancel() {
        self.sender = nil
    }
}

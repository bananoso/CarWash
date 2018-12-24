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

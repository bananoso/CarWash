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

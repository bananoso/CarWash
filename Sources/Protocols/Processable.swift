//
//  Processable.swift
//  CarWashProject
//
//  Created by Student on 21.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

protocol Processable {
    
    associatedtype ProcessingObject
    
    func process(object: ProcessingObject)
}

//
//  Stateable.swift
//  carWash
//
//  Created by Student on 07.11.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

protocol Stateable: class {
    
    associatedtype ProcessingObject: MoneyGiver
    
    var state: Staff<ProcessingObject>.State { get set }
}

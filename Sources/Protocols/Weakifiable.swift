//
//  Weakifiable.swift
//  CarWashProject
//
//  Created by Student on 18.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

protocol Weakifiable: class { }

extension Weakifiable {
    
    var weak: Weak<Self> {
        return weakify(self)
    }
}

extension NSObject: Weakifiable { }

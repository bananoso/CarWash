//
//  Weak.swift
//  CarWashProject
//
//  Created by Student on 17.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

struct Weak<Wrapped: AnyObject> {
    
    private(set) weak var value: Wrapped?
    
    init(_ value: Wrapped) {
        self.value = value
    }
    
    func strongify<Result>(_ transform: (Wrapped) -> Result?) -> Result? {
        return self.value.flatMap(transform)
    }
}

//
//  CompositCancellableProperty.swift
//  CarWashProject
//
//  Created by Mosin Dmitry on 24.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class CompositCancellableProperty: AbstractCancellableProperty<[Cancellable]> {
    
    init() {
        super.init(initial: []) {
            $0.forEach { $0.cancel() }
        }
    }
}

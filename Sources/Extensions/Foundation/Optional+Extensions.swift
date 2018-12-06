//
//  Optional+Extension.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension Optional {
    
    func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
    
    func or(_ execute: () -> ()) {
        if self == nil {
            execute()
        }
    }
}

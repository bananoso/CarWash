//
//  Strideable+Extension.swift
//  carWash
//
//  Created by Student on 26.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension Strideable where Self.Stride: SignedInteger, Self: ExpressibleByIntegerLiteral {
    
    func times(_ execute: () -> ()) {
        (0..<self).forEach {_ in
            execute()
        }
    }
}

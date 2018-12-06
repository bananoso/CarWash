//
//  DispatchQueue+Extension.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    static var background: DispatchQueue {
        return .global(qos: .background)
    }
}

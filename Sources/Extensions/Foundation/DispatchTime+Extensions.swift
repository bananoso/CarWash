//
//  DispathTime+Extension.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension DispatchTime {
    
    static func after(interval: TimeInterval) -> DispatchTime {
        return .now() + interval
    }
}

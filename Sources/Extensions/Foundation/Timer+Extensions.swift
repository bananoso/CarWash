//
//  Timer+Extensions.swift
//  carWash
//
//  Created by Student on 14.11.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension Timer {
    
    static func scheduledWeakTimer(
        interval: TimeInterval,
        repeats: Bool,
        handler: @escaping () -> ()
    )
        -> Timer
    {
        let weakHandler = TimerWeakHandler(handler: handler)
        
        return self.scheduledTimer(
            timeInterval: interval,
            target: weakHandler,
            selector: #selector(weakHandler.execute),
            userInfo: nil,
            repeats: repeats
        )
    }
}

fileprivate class TimerWeakHandler {
    
    private var handler: () -> ()
    
    init(handler: @escaping () -> ()) {
        self.handler = handler
    }
    
    @objc func execute() {
        self.handler()
    }
}

//
//  CarFactory.swift
//  carWash
//
//  Created by Student on 07.11.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class CarFactory {

    var isRuning: Bool {
        return self.timer != nil
    }
    
    private var timer: Timer? {
        willSet { self.invalidate() }
    }
    
    private let service: WashService
    private let queue: DispatchQueue

    deinit {
        print("Factory deinit")
        self.invalidate()
        self.stop()
    }
    
    init(for service: WashService, queue: DispatchQueue = .background) {
        self.service = service
        self.queue = queue
    }
    
    func start() {
        self.timer = Timer.scheduledWeakTimer(interval: 5.0, repeats: true) { [weak self] in
            10.times {
                self?.queue.async {
                    self?.service.wash(car: Car(money: 10))
                }
            }
        }
    }
    
    func stop() {
        self.timer = nil
    }
    
    func invalidate() {
        self.timer?.invalidate()
    }
}

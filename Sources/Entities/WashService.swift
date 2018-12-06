//
//  WashService.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class WashService: Observer {
    
    let id: Int
    
    private let washers: Atomic<[Washer]>
    private let director: Director
    private let accountant: Accountant
    private let cars = Queue<Car>()
    
    init(
        id: Int,
        washers: [Washer],
        director: Director,
        accountant: Accountant
    ) {
        self.id = id
        self.washers = Atomic(washers)
        self.director = director
        self.accountant = accountant
        
        self.signObservers()
    }
    
    func wash(car: Car) {
        self.washers.transform {
            $0.first { $0.state == .available }
                .map { $0.asyncDoWork(with: car) }
                .or { self.cars.enqueue(car) }
        }
    }
    
    private func signObservers() {
        let accountant = self.accountant
        
        self.washers.value.forEach { washer in
            washer.addObserver(self, event: Washer.Event.onPendingProcessing.rawValue) {_ in
                accountant.asyncDoWork(with: washer)
            }
            washer.addObserver(self, event: Washer.Event.onAvailable.rawValue) {_ in
                self.cars.dequeue().do(washer.asyncDoWork)
            }
        }
        
        accountant.addObserver(self, event: Accountant.Event.onPendingProcessing.rawValue) {_ in
            self.director.asyncDoWork(with: accountant)
        }
    }
}

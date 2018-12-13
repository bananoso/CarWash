//
//  WashService.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class WashService {
    
    private let washers: Atomic<[Washer]>
    private let director: Director
    private let accountant: Accountant
    private let cars = Queue<Car>()
    
    private let observers = ObserverCollection<Staff.State>()
    
    deinit {
        self.observers.forEach {
            $0.cancel()
        }
    }
    
    init(
        washers: [Washer],
        director: Director,
        accountant: Accountant
    ) {
        self.washers = Atomic(washers)
        self.director = director
        self.accountant = accountant
        
        self.signObservers()
    }
    
    func wash(car: Car) {
        self.washers.transform {
            $0.first { $0.state == .available }
                .map { $0.asyncDoWork(with: car) }
                .ifNil { self.cars.enqueue(car) }
        }
    }
    
    private func signObservers() {
        let observers = self.observers
        
        self.washers.value.forEach { washer in
            let observer = washer.observer { [weak self, weak washer] in
                switch $0 {
                case .available: self?.cars.dequeue().apply(washer?.asyncDoWork)
                case .pendingProcessing: washer.apply(self?.accountant.asyncDoWork)
                case .busy: return
                }
            }
            
            observers.add(observer)
        }
        
        let observer = self.accountant.observer { [weak self] in
            if $0 == .pendingProcessing {
                (self?.accountant).apply(self?.director.asyncDoWork)
            }
        }
        
        observers.add(observer)
    }
}

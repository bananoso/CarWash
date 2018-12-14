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
    
    private let observers = Staff.Observers()
    
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
        let washers = self.washers.value
        
        observers += washers.map { washer in
            washer.observer(property: .available) { [weak self] in
                switch $0 {
                case .available: self?.cars.dequeue().apply(washer.asyncDoWork)
                case .pendingProcessing: self?.accountant.asyncDoWork(with: washer)
                case .busy: return
                }
            }
        }
        
        let observer = self.accountant.observer(property: .available) { [weak self] in
            if $0 == .pendingProcessing {
                (self?.accountant).apply(self?.director.asyncDoWork)
            }
        }
        
        observers.add(observer)
    }
}

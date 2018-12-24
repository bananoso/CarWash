//
//  WashService.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class WashService {
    
    private let washerManager: EmployeeManager<Washer, Car>
    private let accountantManager: EmployeeManager<Accountant, Washer>
    private let directorManager: EmployeeManager<Director, Accountant>

    private let observers = CompositCancellableProperty()
    
    init(washers: [Washer], accountants: [Accountant], directors: [Director]) {
        self.washerManager = EmployeeManager(washers)
        self.accountantManager = EmployeeManager(accountants)
        self.directorManager = EmployeeManager(directors)
        
        self.signObservers()
    }
    
    func wash(car: Car) {
        self.washerManager.asyncDoWork(with: car)
    }
    
    func signObservers() {
        let washerObserver = self.washerManager.observer(handler: self.accountantManager.asyncDoWork)
        let accountantObserver = self.accountantManager.observer(handler: self.directorManager.asyncDoWork)
        
        self.observers.value = [washerObserver, accountantObserver]
    }
}

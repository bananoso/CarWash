//
//  WashService.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class WashService {
    
    private typealias WasherManager = EmployeeManager<Washer, Car>
    private typealias AccountantManager = EmployeeManager<Accountant, Washer>
    private typealias DirectorManager = EmployeeManager<Director, Accountant>
    
    private let washerManager: WasherManager
    private let accountantManager: AccountantManager
    private let directorManager: DirectorManager

    private var washerObservers = [WasherManager.Observer]()
    private var accountantObservers = [AccountantManager.Observer]()
    
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
        
        self.washerObservers.append(washerObserver)
        self.accountantObservers.append(accountantObserver)
    }
}

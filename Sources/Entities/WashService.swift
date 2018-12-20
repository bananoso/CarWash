//
//  WashService.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class WashService {
    
    private let washersManager: EmployeeManager<Washer, Car>
    private let accountantManager: EmployeeManager<Accountant, Washer>
    private let directorManager: EmployeeManager<Director, Accountant>

    init(washers: [Washer], accountants: [Accountant], directors: [Director]) {
        self.washersManager = EmployeeManager(processableObjects: washers)
        self.accountantManager = EmployeeManager(processableObjects: accountants)
        self.directorManager = EmployeeManager(processableObjects: directors)
        
        self.washersManager.observer(handler: self.accountantManager.asyncDoWork)
        self.accountantManager.observer(handler: self.directorManager.asyncDoWork)
    }
    
    func wash(car: Car) {
        self.washersManager.asyncDoWork(with: car)
    }
}

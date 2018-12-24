//
//  main.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

let washers = (0...3).map { Washer(name: "Ivan\($0)") }
let directors = [Director(name: "Petro")]
let accountants = [Accountant(name: "Alex")]

let washService = WashService(washers: washers, accountants: accountants, directors: directors)

var factory: CarFactory? = CarFactory(for: washService)
factory?.start()

DispatchQueue.background.asyncAfter(deadline: .after(interval: 25.0)) {
    factory?.cancel()
}

RunLoop.current.run()

//
//  MoneyReceiver+Extension.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

protocol MoneyReceiver {
    
    func receive(money: Int)
}

extension MoneyReceiver {
    
    func receiveMoney(from moneyGiver: MoneyGiver) {
        self.receive(money: moneyGiver.giveMoney())
    }
}

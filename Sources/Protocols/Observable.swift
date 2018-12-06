//
//  Observable.swift
//  CarWashProject
//
//  Created by Student on 06.12.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

protocol Observable {
    
    func addObserver(_ observer: Observer, event: String, handler: @escaping F.EventHandler)
    
    func removeObserver(_ observer: Observer, event: String)
}

//
//  F.swift
//  carWash
//
//  Created by Student on 25.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

enum F {
    
    typealias VoidExecute = () -> ()
    typealias Execute<Value> = (Value) -> ()
    
    typealias VoidCompletion = () -> ()
    typealias Completion<Value> = (Value) -> ()
    
    typealias Predicate<Value> = (Value) -> Bool
    
    typealias EventHandler = (Observable) -> ()
}

func when<Result>(_ condition: Bool, execute: () -> Result) -> Result? {
    return condition ? execute() : nil
}

func unless<Result>(_ condition: Bool, execute: () -> Result) -> Result? {
    return when(!condition, execute: execute)
}

//
//  Queue.swift
//  carWash
//
//  Created by Student on 29.10.2018.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

class Queue<Element> {
    
    private let elements: Atomic<[Element]>
    
    init(_ elements: [Element] = []) {
        self.elements = Atomic(elements)
    }
    
    var count: Int {
        return self.elements.value.count
    }
    
    var isEmpty: Bool {
        return self.elements.value.isEmpty
    }
    
    func dequeue() -> Element? {
        return self.elements.modify {
            $0.safeRemoveFirst()
        }
    }

    func enqueue(_ value: Element) {
        self.elements.modify {
            $0.append(value)
        }
    }
}

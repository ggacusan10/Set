//
//  Card.swift
//  Set
//
//  Created by Gillian Gacusan on 7/4/18.
//  Copyright © 2018 Gillian Gacusan. All rights reserved.
//

import Foundation

struct Card: Equatable {
    
    var isMatched = false
    
    var shapeId: Int
    var colorId: Int
    var shadeId: Int
    var numberId: Int
    
    static var idFactory: Int = 0
    
    static func generateId() -> Int {
        idFactory = Int.random(upperbound: 3)
        return idFactory
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (
            (((lhs.shadeId == rhs.shadeId) &&
                lhs.colorId == rhs.colorId) &&
                lhs.shapeId == rhs.shapeId) &&
                lhs.numberId == rhs.numberId
        )
    }
    
    init() {
        self.shapeId = Card.generateId()
        self.colorId = Card.generateId()
        self.shadeId = Card.generateId()
        self.numberId = Card.generateId()
    }
}

extension Int {
    static func random(upperbound: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upperbound)))
    }
}


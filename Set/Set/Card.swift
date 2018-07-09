//
//  Card.swift
//  Set
//
//  Created by Gillian Gacusan on 7/4/18.
//  Copyright © 2018 Gillian Gacusan. All rights reserved.
//

import Foundation

struct Card {
    
    var isMatched = false
    
    var shapeId: Int
    var colorId: Int
    var shadeId: Int
    var numberId: Int
    
    static var idFactory: Int = 0
    
    static func generateId() -> Int {
        idFactory = Int(arc4random_uniform(UInt32(3)))
        return idFactory
    }
    
    init() {
        self.shapeId = Card.generateId()
        self.colorId = Card.generateId()
        self.shadeId = Card.generateId()
        self.numberId = Card.generateId()
    }
}


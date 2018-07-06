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
    var identifier: Int
    
    enum Shape {
        case alpha
        case beta
        case charlie
    }
    
    enum Number {
        case one
        case two
        case three
    }
    
    enum Shade {
        case empty
        case filled
        case striped
    }
    
    enum Color {
        case red
        case blue
        case green
    }
}

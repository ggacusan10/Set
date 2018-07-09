//
//  Set.swift
//  Set
//
//  Created by Gillian Gacusan on 7/7/18.
//  Copyright © 2018 Gillian Gacusan. All rights reserved.
//

import Foundation

class Set {
    var cardDeck = [Card]() // all the 81 cards
    var selectedCards = [Card]() // should only contain 3 cards
    var matchedCards = [Card]() // contains all matched cards
    
    var matchText: String = ""
    
    /*
     
     1. Has a list of cards that are being played
     2. Has selected cards
     3. Knows if the selected cards are a match/not a match
     4. Has deck of cards to deal
     5. Keeps track of already matched cards
     
     * Try to match
     * And deal on demand
     
    */
    
    func tryToMatch(at index: Int) { // picks a card
        print(#function)
        // scan the current playing cards for any match and is less than 24
        // if no match exists, then enable Deal 3 More Cards
        
        if selectedCards.count < 3 { // still has to pick 3 cards to match
            let card = cardDeck[index]
            selectedCards.append(card)
            matchText = ""
        }
        
        if selectedCards.count == 3 { // each feature matches or does not match
            let result = match(cards: selectedCards)
            if result == true {
                matchText = "It's a Set!"
                print("It's a Set!")
                selectedCards.removeAll()
            } else {
                matchText = "Not a Set"
                print("Not a Set")
                selectedCards.removeAll()
            }
        }
    }
    
    func match(cards card: [Card]) -> Bool{
        var match = [Bool]()
        
        var shapeIds = [Int]()
        var colorIds = [Int]()
        var shadeIds = [Int]()
        var numberIds = [Int]()
        
        for index in 0..<card.count {
            shapeIds.append(card[index].shapeId)
            colorIds.append(card[index].colorId)
            shadeIds.append(card[index].shadeId)
            numberIds.append(card[index].numberId)
        }
        
        match.append(matchId(array: shapeIds))
        match.append(matchId(array: colorIds))
        match.append(matchId(array: shadeIds))
        match.append(matchId(array: numberIds))
        
        print("Match: \(match)")
        
        if(!match.contains(false)) {
            return true
        } else {
            return false
        }
    }
    
    func matchId(array: [Int]) -> Bool {
        var result = false
        
        // everything matches
        if(array[0] == array[1] && array[0] == array[2]) {
            result = true
        }
        
        // if everything is different
        if((array[0] != array[1] &&
            array[0] != array[2]) &&
            array[1] != array[2]){
            result = true
        }
        return result
    }
    

    init() {
        for _ in 0..<24 {
            var card = Card()
            //print("Card gen: \(card)")
            
            if cardDeck.contains(where: {
                 ((($0.colorId == card.colorId &&
                    $0.shapeId == card.shapeId) &&
                    $0.shadeId == card.shadeId) &&
                    $0.numberId == card.numberId)}) {
                print("Found similar card. Will make new")
                repeat
                {
                    card = Card()
                //    print("New card generated: \(card)\n")
                } while cardDeck.contains(where: {
                     ((($0.colorId == card.colorId &&
                        $0.shapeId == card.shapeId) &&
                        $0.shadeId == card.shadeId) &&
                        $0.numberId == card.numberId)})
            }
            cardDeck.append(card)
        }
        print("Card deck count: \(cardDeck.count)")
    }
}








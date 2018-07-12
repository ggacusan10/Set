//
//  Set.swift
//  Set
//
//  Created by Gillian Gacusan on 7/7/18.
//  Copyright © 2018 Gillian Gacusan. All rights reserved.
//

/*
 1. Has a list of cards that are being played ✅
 2. Has selected cards ✅
 3. Knows if the selected cards are a match/not a match ✅
 4. Has deck of cards to deal ✅
 5. Keeps track of already matched cards ✅
 
 * Deal on demand ✅
 */

import Foundation

class Set {
    // all the 81 cards
    var cardDeck: [Card] = {
        var array = [Card]()
        for _ in 0..<81 {
            var card = Card()
            if array.contains(where: {$0 == card}) {
                repeat {
                    card = Card()
                } while array.contains(where: {$0 == card})
            }
            array.append(card)
        }
        return array
    }()

    var selectedCards = [Card]() // should only contain 3 cards
    var matchedCards = [Card]() // contains all matched cards
    var currentlyPlayingCards = [Card]() // contains all the cards that are being played
    
    var matchText: String = ""
    
    var replaceCurrentCards = false
    
    func restartGame() {
        cardDeck.append(contentsOf: matchedCards)
        cardDeck.append(contentsOf: currentlyPlayingCards)
        
        for i in cardDeck.indices {
            let random = Int.random(upperbound: cardDeck.count)
            cardDeck.swapAt(i, random)
        }
        
        currentlyPlayingCards.removeAll()
        matchedCards.removeAll()
        
        for _ in 0..<12 { // start with 12 cards
            let card = cardDeck.removeFirst()
            currentlyPlayingCards.append(card)
        }
        print("Refreshed. Card Deck size: \(cardDeck.count)")
    }
    
    func dealMoreCards() -> Card { // adds more cards
        let card = cardDeck.removeFirst()
        currentlyPlayingCards.append(card)
        return card
    }
    
    func replaceCard(atIndex index: Int) -> Card { // if there is a match, replace those current cards with new cards
        let card = cardDeck.removeFirst()
        currentlyPlayingCards.replaceSubrange(index..<(index+1), with: [card])
        return card
    }
    
    func tryToMatch(at index: Int) { // picks a card
        print(#function)
        
        let card = currentlyPlayingCards[index]

        if selectedCards.count == 3 { // fixes the wrap-around
            selectedCards.removeAll()
        }
        if selectedCards.count < 3 { // still has to pick 3 cards to match
            replaceCurrentCards = false
            
            // Already chosen card / Deselect
            if selectedCards.contains(where: {$0 == card}) {
                print("This card is already chosen. Going to deselect")
                if let index = selectedCards.index(where: {$0 == card}) {
                    selectedCards.remove(at: index)
                }
            } else {
                selectedCards.append(card)
                matchText = ""
            }
        }
        if selectedCards.count == 3 { // check if it's a correct Set
            let result = match(cards: selectedCards)
            if result == true {
                matchText = "It's a Set!"
                print("It's a Set!")
                matchedCards.append(contentsOf: selectedCards)
                replaceCurrentCards = true
            } else {
                matchText = "Not a Set"
                print("Not a Set")
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
        
        // if each feature matches
        if(array[0] == array[1] && array[0] == array[2]) {
            result = true
        }
        
        // if each feature is unique
        if((array[0] != array[1] &&
            array[0] != array[2]) &&
            array[1] != array[2]){
            result = true
        }
        return result
    }
    
    init() {
        for _ in 0..<12 { // start with 12 cards
            let card = cardDeck.removeFirst()
            currentlyPlayingCards.append(card)
        }
        print("Init card deck size: \(cardDeck.count)")
    }
}

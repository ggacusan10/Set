//
//  ViewController.swift
//  Set
//
//  Created by Gillian Gacusan on 7/4/18.
//  Copyright © 2018 Gillian Gacusan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = Set()
    
    var currentlyVisibleButtons = [UIButton]()

    @IBOutlet weak var matchLabel: UILabel!
    
    @IBAction func dealMoreCards(_ sender: UIButton) {
        print("Deal More Cards pressed")
        if game.cardDeck.count > 0, currentlyVisibleButtons.count < 24 {
            let pastSize = currentlyVisibleButtons.count
            for i in 0...2 {
                let button = styleButton(atIndex: (pastSize+i), method: "deal")
                currentlyVisibleButtons.append(button)
            }
        }
        print("Card deck size: \(game.cardDeck.count)")
    }
    
    @IBOutlet var setButtons: [UIButton]! {
        didSet {
            for i in 0..<24 {
                let button = setButtons[i]
                button.setTitle("", for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0)
            }
        }
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        if let index = setButtons.index(of: sender){
            let button = setButtons[index]
            if currentlyVisibleButtons.contains(button), button.backgroundColor != #colorLiteral(red: 0.8443250317, green: 0.8443250317, blue: 0.8443250317, alpha: 0) { // only if the button is visible on the UI
                game.tryToMatch(at: index)
                updateView()
                matchLabel.text = game.matchText
                print("Touched card: \(index)")
            }
        }
    }
   
    func updateView() {
        for index in currentlyVisibleButtons.indices {
            var button = currentlyVisibleButtons[index]
            let card = game.currentlyPlayingCards[index]
            
            button.layer.borderWidth = (game.selectedCards.contains(card)) ? 3.0:0
            button.layer.borderColor = (game.selectedCards.contains(card)) ? #colorLiteral(red: 0.2903060761, green: 0.893158637, blue: 1, alpha: 1):#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            
            if game.replaceCurrentCards, game.cardDeck.count > 0 {
                if button.layer.borderColor == #colorLiteral(red: 0.2903060761, green: 0.893158637, blue: 1, alpha: 1) {
                    print("Will replace \(index)")
                    button = styleButton(atIndex: index, method: "replace")
                }
            }
            else if game.replaceCurrentCards,
                game.cardDeck.count == 0,
                button.layer.borderColor == #colorLiteral(red: 0.2903060761, green: 0.893158637, blue: 1, alpha: 1) {
                button = styleButton(atIndex: index, method: "disappear")
            }
        }
        print("Card deck size: \(game.cardDeck.count)")
        print("Currently playing size: \(game.currentlyPlayingCards.count)")
    }
    
    func getAttributes(shadeId shade: Int, withColor color: UIColor) -> [NSAttributedStringKey:Any] {
        let attributesArray: [[NSAttributedStringKey:Any]] = [
            [.strokeColor: color,
             .strokeWidth: 5.0], // empty
            
            [.strokeColor: color,
             .strokeWidth: -6.0,
             .foregroundColor: UIColor.black.withAlphaComponent(0.2)], // striped
            
            [.foregroundColor: color.withAlphaComponent(1.00)] // filled
        ]
        return attributesArray[shade]
    }
    
    let shapes = ["▲", "●", "■"]
    let colors = [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
    
    @IBAction func newGame(_ sender: UIButton) {
        print("New game pressed")
    }
    
    func styleButton(atIndex index: Int, method: String? = nil) -> UIButton {
        let button = setButtons[index]
        var card = Card()
        
        if method == "replace" {
            card = game.replaceCard(atIndex: index)
            button.layer.borderColor = #colorLiteral(red: 0.8443250317, green: 0.8443250317, blue: 0.8443250317, alpha: 0)
        } else if method == "deal" {
            card = game.dealMoreCards()
        } else if method == "disappear" {
            button.layer.borderColor = #colorLiteral(red: 0.8443250317, green: 0.8443250317, blue: 0.8443250317, alpha: 0)
            button.backgroundColor = #colorLiteral(red: 0.8443250317, green: 0.8443250317, blue: 0.8443250317, alpha: 0)
            button.layer.borderWidth = 0
            let title: String = ""
            let attributes = getAttributes(shadeId: 0, withColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
            let attributedString = NSAttributedString(string: title, attributes: attributes)
            button.setAttributedTitle(attributedString, for: .normal)
            return button
        } else {
            card = game.currentlyPlayingCards[index]
        }
        
        var title = String()
        for _ in 0...card.numberId {
            title.append(shapes[card.shapeId])
        }
        
        let attributes = getAttributes(shadeId: card.shadeId, withColor: colors[card.colorId])
        
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        return button
    }
    
    func startGame() {
        matchLabel.text = ""
        for i in 0..<12 {
            let button = styleButton(atIndex: i)
            currentlyVisibleButtons.append(button)
        }
    }

    override func viewDidLoad() {
        startGame()
    }
}


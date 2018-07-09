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
    
    @IBOutlet weak var matchLabel: UILabel!
    
    @IBAction func dealMoreCards(_ sender: UIButton) {
        print("Deal More Cards pressed")
    }
    
    @IBOutlet var setButtons: [UIButton]!
    
    var numberOfCardsSelected = 0
    
    @IBAction func touchButton(_ sender: UIButton) {
        numberOfCardsSelected += 1
        if let index = setButtons.index(of: sender) {
            let button = setButtons[index]
            if(numberOfCardsSelected <= 3) {
                button.layer.borderWidth = 3.0
                button.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            }
            else {
                resetAllButtonColors()
                button.layer.borderWidth = 3.0
                button.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            }
            game.tryToMatch(at: index)
            matchLabel.text = game.matchText
            print("Touched card: \(index)")
        }
        print("Cards selected: \(numberOfCardsSelected)\n")
    }
    
    func resetAllButtonColors() {
        // clear everything
        for index in setButtons.indices {
            let button = setButtons[index]
            button.layer.borderWidth = 0
            button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
        numberOfCardsSelected = 1
    }
    
    /*func updateView() {
        for i in setButtons.indices {
            let button = setButtons[i]
            let random = Int(arc4random_uniform(UInt32(shades.count)))
            
            let attributedString = NSAttributedString(string: shades[random], attributes: attributes)
            
            button.setAttributedTitle(attributedString, for: .normal)
        }
    }*/
    
    let attributes: [NSAttributedStringKey:Any] = [
        //  .strokeColor: UIColor.blue,
        //  .strokeWidth: 5.0,
        .foregroundColor: UIColor.black.withAlphaComponent(1.00)
    ]
    
    func getAttributes(shadeId shade: Int, withColor color: UIColor) -> [NSAttributedStringKey:Any]? {
        
        switch shade {
        case 0:
            return [ // empty
                .strokeColor: color,
                .strokeWidth: 5.0
            ]
        case 1:
            return [ // striped
                .strokeColor: color,
                .strokeWidth: -5.0,
                .foregroundColor: UIColor.black.withAlphaComponent(0.2)
            ]
        case 2:
            return [ // filled
                .strokeColor: color,
                .strokeWidth: -5.0,
                .foregroundColor: color.withAlphaComponent(1.00)
            ]
        default:
            return nil
        }
    }
    
    let shapes = ["▲", "●", "■"]
    let colors = [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
    
    func startGame() {
        for i in 0..<24 {
            let button = setButtons[i]
            let card = game.cardDeck[i]
            
            var title = String()
            
            for _ in 0...card.numberId {
                title.append(shapes[card.shapeId])
            }
            
            let attributes = getAttributes(shadeId: card.shadeId, withColor: colors[card.colorId])
            
            print("Card: \(card)")
            
            let attributedString = NSAttributedString(string: title, attributes: attributes)
            
            button.setAttributedTitle(attributedString, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }

    override func viewDidLoad() {
        startGame()
    }
}


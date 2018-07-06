//
//  ViewController.swift
//  Set
//
//  Created by Gillian Gacusan on 7/4/18.
//  Copyright © 2018 Gillian Gacusan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let attributes: [NSAttributedStringKey:Any] = [
        .strokeColor: UIColor.red,
        .strokeWidth: -5.0,
        .foregroundColor: UIColor.blue.withAlphaComponent(0.15),
    ]
   
    let symbols = ["▲", "●", "■"]
    
    var numberOfCardsSelected = 0

    @IBAction func dealMoreCards(_ sender: UIButton) {
        print("Deal More Cards pressed")
    }
    
    @IBOutlet var setButtons: [UIButton]!
    
    // FIXME: correct the selected cards outline
    @IBAction func touchButton(_ sender: UIButton) {
        numberOfCardsSelected += 1
        if let index = setButtons.index(of: sender) {
            let button = setButtons[index]
            if(numberOfCardsSelected <= 3) {
                button.layer.borderWidth = 3.0
                button.layer.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            } else {
                resetAllButtonColors()
                button.layer.borderWidth = 3.0
                button.layer.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            }
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
    
    func updateView() {
        for i in setButtons.indices {
            let button = setButtons[i]
            let random = Int(arc4random_uniform(UInt32(symbols.count)))
            
            let attributedString = NSAttributedString(string: symbols[random], attributes: attributes)
            
            button.setAttributedTitle(attributedString, for: .normal)
        }
    }

    override func viewDidLoad() {
        updateView()
    }
}


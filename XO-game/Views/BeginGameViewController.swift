//
//  BeginGameViewController.swift
//  XO-game
//
//  Created by Вячеслав Поляков on 03.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class BeginGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func twoPlayerButton(_ sender: Any) {
    }
    
    @IBAction func oneVsPCButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? GameViewController else {return}
        switch segue.identifier {
        case "twoPlayerSegue":
            vc.gameMode = .twoPlayer
        case "onePlayerSegue":
            vc.gameMode = .onePlayer
        case "fewTurn":
            vc.gameMode = .fewTurn
        case .none:
            vc.gameMode = .twoPlayer
        case .some(_):
            vc.gameMode = .twoPlayer
        }
    }
}

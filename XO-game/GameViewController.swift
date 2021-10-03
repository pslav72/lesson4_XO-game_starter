//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private let gameboard = Gameboard()
    private var counterMove: Int = 0
    
    var gameMode: GameMode = .twoPlayer
    private var player: Player = .first
    
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    private lazy var referee = Referee(gameboard: self.gameboard)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondPlayerTurnLabel.text = gameMode == .twoPlayer ? "2nd player" : "PC player"
        self.goToFirstState()
        self.onSelectPosition()
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        self.gameboard.clear()
        self.gameboardView.clear()
        self.goToFirstState()
        self.counterMove = 0
    }
    
    private func goToFirstState() {
        let player = Player.first
        self.currentState = PlayerInputState(player: .first,
                                             markViewPrototype: player.markViewPrototype,
                                             gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)
    }
    
    private func onSelectPosition() {
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            let setRandomPosition = GameboardPosition(column: Int.random(in: 0..<GameboardSize.columns),
                                                row: Int.random(in: 0..<GameboardSize.rows))
            
            print("position \(position) \(self.gameMode) \(self.player) \(setRandomPosition)")
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.counterMove += 1
                print("counterMove \(self.counterMove)")
                self.goToNextState()
            }
        }
    }

    private func goToNextState() {
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        
        if counterMove >= 9 {
            currentState = GameEndedState(winner: nil, gameViewController: self)
            return
        }
        
        if let playerInputState = currentState as? PlayerInputState {
            self.player = gameMode == .twoPlayer ? playerInputState.player.next : playerInputState.player.nextOne
            self.currentState = PlayerInputState(player: player,
                                                 markViewPrototype: player.markViewPrototype,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
        }
        
        if self.player == .pc {
            print("player PC")
            
            while !self.currentState.isCompleted {
                let setRandomPosition = GameboardPosition(column: Int.random(in: 0..<GameboardSize.columns), row: Int.random(in: 0..<GameboardSize.rows))
                print("position \(setRandomPosition) \(self.gameMode) \(self.player)")
                self.currentState.addMark(at: setRandomPosition)
            }
            self.counterMove += 1
            self.goToNextState()
        }
    }
    

}


//
//  TurnInvokeCommand.swift
//  XO-game
//
//  Created by Вячеслав Поляков on 03.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

internal final class TurnInvokeCommand {
    
    // MARK: Singleton
    
    internal static let shared = TurnInvokeCommand()
    
    // MARK: Private properties
    
//    private let turnsCommands = TurnsCommands()
    //    private var command: [Command] = []
    private let batchSize = 10
    private var turns: [TurnActionCommand] = []
    private var findWinner: Bool = false

    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    // MARK: Internal
    
    internal func addTurnCommand(_ command: TurnActionCommand) {
        self.turns.append(command)
        self.executeCommandsIfNeeded()
    }
    
    internal func clear() {
        self.turns.removeAll()
    }
    // MARK: Private
    
    private func executeCommandsIfNeeded() {
        
        guard self.turns.count >= batchSize else {
            return
        }
        let _ = self.turns.map { value in
            if !findWinner {
                let player = value.player.player
                let markViewPrototype = value.player.markViewPrototype
                let position = value.position
                guard let gameViewController = value.player.gameViewController,
                      let gameboard = value.player.gameboard,
                      let gameboardView = value.player.gameboardView
                else { return }
                self.currentState = PlayerInputState(player: player,
                                                     markViewPrototype: markViewPrototype,
                                                     gameViewController: gameViewController,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView)
                self.currentState.addMarkArray(at: position)
                let referee = Referee(gameboard: gameboard)
                if let winner = referee.determineWinner() {
                    print("Winner \(gameViewController) \(winner)")
                    self.findWinner = true
                    self.currentState = GameEndedState(winner: winner, gameViewController: gameViewController)
                    return
                }
            }
        }
    }
}

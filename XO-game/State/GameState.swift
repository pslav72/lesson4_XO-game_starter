//
//  GameState.swift
//  XO-game
//
//  Created by Вячеслав Поляков on 02.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

public protocol GameState {
    
    var isCompleted: Bool { get }
    
    func begin()
    
    func addMark(at position: GameboardPosition)
    
    func addMarkArray(at position: GameboardPosition)
}

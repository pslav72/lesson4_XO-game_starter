//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    case pc
    
    var next: Player {
        switch self {
        case .first: return .second
        case .second: return .first
        case .pc: return .first
        }
    }
    
    var nextOne: Player {
        switch self {
        case .first: return .pc
        case .pc: return .first
        case .second: return .first
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first: return XView()
        case .second: return OView()
        case .pc: return OView()
        }
    }
}

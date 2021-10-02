//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Вячеслав Поляков on 02.10.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

internal final class LoggerInvoker {
    
    // MARK: Singleton
    
    internal static let shared = LoggerInvoker()
    
    // MARK: Private properties
    
    private let logger = Logger()
    private let batchSize = 10
    private var commands: [LogCommand] = []
    
    // MARK: Internal
    
    internal func addLogCommand(_ command: LogCommand) {
        self.commands.append(command)
        self.executeCommandsIfNeeded()
    }
    
    // MARK: Private
    
    private func executeCommandsIfNeeded() {
        guard self.commands.count >= batchSize else {
            return
        }
        self.commands.forEach { self.logger.writeMessageToLog($0.logMessage) }
        self.commands = []
    }
}

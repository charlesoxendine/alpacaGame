//
//  AlpacaError.swift
//  alpacaGame iOS
//
//  Created by Charles Oxendine on 5/27/23.
//

import Foundation

enum AlpacaError: Error {
    case notEnoughMoney
    case notEnoughResidence
}

extension AlpacaError {
//    var isFatal: Bool {
//        if case AlpacaError.unexpected = self { return true }
//        else { return false }
//    }
}

extension AlpacaError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notEnoughMoney:
            return "Oops! You can't afford that!"
        case .notEnoughResidence:
            return "You must purchase more alpaca housing to do this!"
        }
    }
}

//
//  GameChoices.swift
//  RockPaperScissors
//
//  Created by Admin on 14.04.2023.
//

import SwiftUI

enum Choices: CaseIterable {
    case paper
    case rock
    case scissors
//    case none
    
    var name: String {
        switch self {
        case .paper:
            return "Paper"
        case .rock:
            return "Rock"
        case .scissors:
            return "Scissors"
//        case .none:
//            return ""
        }
    }
    
    var image: Image {
        switch self {
        case .paper:
            return Image("paper")
        case .rock:
            return Image("rock")
        case .scissors:
            return Image("scissors")
//        case .none:
//            return Image("")
        }
    }
    
    static func random() -> Choices {
            return allCases.randomElement()!
        }
}


extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Choices) {
        switch value {
        case .paper:
            appendLiteral("paper")
        case .rock:
            appendLiteral("rock")
        case .scissors:
            appendLiteral("scissors")
//        case .none:
//            appendLiteral("")
        }
    }
}

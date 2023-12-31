//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

protocol StrategyProtocol {
  func isMinGoodHand(
    for street: Street,
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool
}

struct StrategyFactory {
  func makeStrategy(_ strategy: Strategy) -> StrategyProtocol {
    switch strategy {
    case .tightAggressive:
      return TightAggressiveStrategy()
    }
  }
}

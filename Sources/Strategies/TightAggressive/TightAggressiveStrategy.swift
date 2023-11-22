//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct TightAggressiveStrategy: StrategyProtocol {
  private let minGoodHandEvaluator = MinGoodHandEvaluator()

  func isMinGoodHand(
    for street: Street,
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    fatalError("NOT IMPLEMENTED!")
  }
}

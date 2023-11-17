//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Evaluators
import Types

struct MinGoodHandEvaluator {
  private let boardTypeFactory = BoardTypeFactory()

  func isGoodEnough(
    holeCards: [Card],
    communityCards: [Card],
    street: Street
  ) -> Bool {
    //let boardType = boardTypeFactory.makeBoardType(cards: communityCards)
    return false
  }
}

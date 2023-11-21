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
  func minGoodHand(
    communityCards: [Card],
    street: Street
  ) -> MinGoodHand {
    let factory = BoardTypeFactory()
    let boardType = factory.makeBoardType(cards: communityCards)
    return boardType.minGoodHand(for: street)
  }
}

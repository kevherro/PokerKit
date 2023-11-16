//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct RiverEvaluator: StreetEvaluatorProtocol {
  func evaluate(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }
}

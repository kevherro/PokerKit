//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct NonScaryBoard: BoardTypeProtocol {
  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    switch context.street {
    case .flop:
      return .secondPair
    case .turn:
      return .topPair
    case .river:
      return .overpair
    }
  }
}

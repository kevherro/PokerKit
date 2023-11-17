//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct NonScaryBoard: BoardTypeProtocol {
  private let isAceHigh: Bool

  init(context: BoardContext) {
    self.isAceHigh = context.isAceHigh
  }

  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      return .secondPair
    case .turn:
      return .topPair
    case .river:
      return isAceHigh ? .topPairTopKicker : .overpair
    }
  }
}

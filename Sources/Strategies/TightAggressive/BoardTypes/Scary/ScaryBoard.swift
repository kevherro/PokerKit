//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct ScaryBoard: BoardTypeProtocol {
  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    let features = context.features
    let isAceHigh = context.isAceHigh
    let street = context.street

    switch street {
    case .flop:
      return .topPair
    case .turn:
      return isAceHigh ? .topPairTopKicker : .overpair
    case .river:
      return minGoodHand(for: features)
    }
  }

  private func minGoodHand(for features: Set<BoardFeature>) -> MinGoodHand {
    if features == [.threeToFlush] {
      return .flush
    } else if features == [.threeToStraight] {
      return .straight
    } else if features == [.onePair] {
      return .trips
    } else {
      fatalError("invalid features for scary board: \(features)")
    }
  }
}

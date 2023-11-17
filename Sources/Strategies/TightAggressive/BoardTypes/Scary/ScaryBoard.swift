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
    let street = context.street

    switch street {
    case .flop:
      return .topPair
    case .turn:
      return features.contains(.aceHigh) ? .topPairTopKicker : .overpair
    case .river:
      return minGoodHand(for: features)
    }
  }

  private func minGoodHand(for features: Set<BoardFeature>) -> MinGoodHand {
    var adjustedFeatures = features
    adjustedFeatures.remove(.aceHigh)

    if adjustedFeatures == [.threeToFlush] {
      return .flush
    } else if adjustedFeatures == [.threeToStraight] {
      return .straight
    } else if adjustedFeatures == [.onePair] {
      return .trips
    } else {
      fatalError("invalid features for scary board: \(features)")
    }
  }
}

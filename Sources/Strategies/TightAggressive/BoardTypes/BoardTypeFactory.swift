//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Evaluators
import Types

protocol BoardTypeProtocol {
  func minGoodHand(for context: BoardContext) -> MinGoodHand
}

struct BoardContext {
  let street: Street
  let features: Set<BoardFeature>
}

struct BoardTypeFactory {
  private let boardEvaluator = BoardEvaluator()

  func makeBoardType(cards: [Card]) -> BoardTypeProtocol {
    if isScary(cards: cards) {
      return ScaryBoard()
    } else if isVeryScary(cards: cards) {
      return VeryScaryBoard()
    } else {
      return NonScaryBoard()
    }
  }

  private func isScary(cards: [Card]) -> Bool {
    var features = [BoardFeature]()
    if boardEvaluator.hasOnePair(cards: cards) {
      features.append(.onePair)
    }
    if boardEvaluator.hasThreeToFlush(cards: cards) {
      features.append(.threeToFlush)
    }
    if boardEvaluator.hasThreeToStraight(cards: cards) {
      features.append(.threeToStraight)
    }
    return features.count == 1
  }

  private func isVeryScary(cards: [Card]) -> Bool {
    return false
  }
}

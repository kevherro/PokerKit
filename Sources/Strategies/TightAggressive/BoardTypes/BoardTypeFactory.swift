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
  func minGoodHand(for street: Street) -> MinGoodHand
}

struct BoardTypeFactory {
  private let boardEvaluator = BoardEvaluator()

  func makeBoardType(cards: [Card]) -> BoardTypeProtocol {
    let context = BoardContextBuilder().build(cards: cards)

    if isVeryScary(context: context) {
      return VeryScaryBoard(context: context)
    }

    if isScary(context: context) {
      return ScaryBoard(context: context)
    }

    return NonScaryBoard(context: context)
  }

  private func isScary(context: BoardContext) -> Bool {
    return context.featureSet == .onePair
      || context.featureSet == .threeToStraight
      || context.featureSet == .threeToFlush
  }

  private func isVeryScary(context: BoardContext) -> Bool {
    return context.featureSet == .possibleStraightPossibleFlush
      || context.featureSet == .fourToFlush
      || context.featureSet == .fourToStraight
      || context.featureSet == .fourToStraightOnePair
      || context.featureSet == .possibleFlushOnePair
      || context.featureSet == .twoPair
  }
}

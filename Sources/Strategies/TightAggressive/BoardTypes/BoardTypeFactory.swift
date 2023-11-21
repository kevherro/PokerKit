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
    let label = context.vector.label
    return label == .onePair
      || label == .threeToStraight
      || label == .threeToFlush
  }

  private func isVeryScary(context: BoardContext) -> Bool {
    let label = context.vector.label
    return label == .possibleStraightPossibleFlush
      || label == .fourToFlush
      || label == .fourToStraight
      || label == .fourToStraightOnePair
      || label == .possibleFlushOnePair
      || label == .twoPair
  }
}

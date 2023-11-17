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
  let isAceHigh: Bool
  let isTJQK: Bool
}

struct BoardTypeFactory {
  private let boardEvaluator = BoardEvaluator()

  func makeBoardType(cards: [Card]) -> BoardTypeProtocol {
    if isVeryScary(cards: cards) {
      return VeryScaryBoard()
    }

    if isScary(cards: cards) {
      return ScaryBoard()
    }

    return NonScaryBoard()
  }

  private func isScary(cards: [Card]) -> Bool {
    let hasOnePair = boardEvaluator.hasOnePair(cards: cards)

    let hasThreeToStraight =
      boardEvaluator.hasThreeToStraight(cards: cards)
      && !boardEvaluator.hasFourToStraight(cards: cards)

    let hasThreeToFlush =
      boardEvaluator.hasThreeToFlush(cards: cards)
      && !boardEvaluator.hasFourToFlush(cards: cards)

    let nTrue = [
      hasOnePair,
      hasThreeToStraight,
      hasThreeToFlush,
    ].filter { $0 }.count

    return nTrue == 1
  }

  private func isVeryScary(cards: [Card]) -> Bool {
    let hasOnePair = boardEvaluator.hasOnePair(cards: cards)
    let hasTwoPair = boardEvaluator.hasTwoPair(cards: cards)

    let hasFourToStraight = boardEvaluator.hasFourToStraight(cards: cards)
    let hasFourToFlush = boardEvaluator.hasFourToFlush(cards: cards)

    let isStraightPossible =
      boardEvaluator.hasThreeToStraight(cards: cards)
      || hasFourToStraight

    let isFlushPossible =
      boardEvaluator.hasThreeToFlush(cards: cards)
      || hasFourToFlush

    return (isStraightPossible && isFlushPossible && !hasOnePair)
      || (hasFourToFlush && !hasOnePair)
      || (hasFourToStraight && !isFlushPossible && !hasOnePair)
      || (hasFourToStraight && hasOnePair)
      || (isFlushPossible && hasOnePair)
      || hasTwoPair
  }
}

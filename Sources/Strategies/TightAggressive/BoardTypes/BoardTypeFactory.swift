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

struct BoardContext {
  let features: Set<BoardFeature>
  let isAceHigh: Bool
  let hasTJQK: Bool
}

struct BoardContextBuilder {
  private let boardEvaluator = BoardEvaluator()

  func build(cards: [Card]) -> BoardContext {
    let features = features(cards: cards)
    let isAceHigh = boardEvaluator.isAceHigh(cards: cards)
    let hasTJQK = hasTJQK(cards: cards)

    let context = BoardContext(
      features: features,
      isAceHigh: isAceHigh,
      hasTJQK: hasTJQK
    )

    return context
  }

  private func features(cards: [Card]) -> Set<BoardFeature> {
    return []
  }

  private func hasTJQK(cards: [Card]) -> Bool {
    let ranks = cards.map(\.rank)
    return ranks.contains(.ten)
      && ranks.contains(.jack)
      && ranks.contains(.queen)
      && ranks.contains(.king)
  }
}

struct BoardTypeFactory {
  private let boardEvaluator = BoardEvaluator()

  func makeBoardType(cards: [Card]) -> BoardTypeProtocol {
    let context = BoardContextBuilder().build(cards: cards)

    if isVeryScary(cards: cards) {
      return VeryScaryBoard(context: context)
    }

    if isScary(cards: cards) {
      return ScaryBoard(context: context)
    }

    return NonScaryBoard(context: context)
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

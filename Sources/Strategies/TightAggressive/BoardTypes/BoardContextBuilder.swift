//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Evaluators
import Types

enum BoardFeatureSet {
  case onePair
  case twoPair
  case threeToFlush
  case threeToStraight
  case fourToFlush
  case fourToStraight
  case possibleStraightPossibleFlush
  case fourToStraightOnePair
  case possibleFlushOnePair
}

struct BoardContext {
  let featureSet: BoardFeatureSet?
  let isAceHigh: Bool
  let hasTJQK: Bool
}

struct BoardContextBuilder {
  private let boardEvaluator = BoardEvaluator()

  func build(cards: [Card]) -> BoardContext {
    let featureSet = featureSet(cards: cards)
    let isAceHigh = boardEvaluator.isAceHigh(cards: cards)
    let hasTJQK = hasTJQK(cards: cards)

    let context = BoardContext(
      featureSet: featureSet,
      isAceHigh: isAceHigh,
      hasTJQK: hasTJQK
    )

    return context
  }

  private func featureSet(cards: [Card]) -> BoardFeatureSet? {
    let hasOnePair = boardEvaluator.hasOnePair(cards: cards)

    let hasThreeToStraight =
      boardEvaluator.hasThreeToStraight(cards: cards)
      && !boardEvaluator.hasFourToStraight(cards: cards)

    let hasThreeToFlush =
      boardEvaluator.hasThreeToFlush(cards: cards)
      && !boardEvaluator.hasFourToFlush(cards: cards)

    let hasFourToStraight = boardEvaluator.hasFourToStraight(cards: cards)
    let hasFourToFlush = boardEvaluator.hasFourToFlush(cards: cards)

    let isStraightPossible =
      boardEvaluator.hasThreeToStraight(cards: cards)
      || hasFourToStraight

    let isFlushPossible =
      boardEvaluator.hasThreeToFlush(cards: cards)
      || hasFourToFlush

    if isStraightPossible && isFlushPossible && !hasOnePair {
      return .possibleStraightPossibleFlush
    }

    if hasFourToFlush && !hasOnePair {
      return .fourToFlush
    }

    if hasFourToStraight && !isFlushPossible && !hasOnePair {
      return .fourToStraight
    }

    if hasFourToStraight && hasOnePair {
      return .fourToStraightOnePair
    }

    if isFlushPossible && hasOnePair {
      return .possibleFlushOnePair
    }

    if boardEvaluator.hasTwoPair(cards: cards) {
      return .twoPair
    }

    if hasOnePair {
      return .onePair
    }

    if hasThreeToStraight {
      return .threeToStraight
    }

    if hasThreeToFlush {
      return .threeToFlush
    }

    return nil
  }

  private func hasTJQK(cards: [Card]) -> Bool {
    let ranks = cards.map(\.rank)
    return ranks.contains(.ten)
      && ranks.contains(.jack)
      && ranks.contains(.queen)
      && ranks.contains(.king)
  }
}

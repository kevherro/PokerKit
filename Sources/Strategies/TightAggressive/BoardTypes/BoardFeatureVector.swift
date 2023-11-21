//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Evaluators
import Types

enum BoardFeatureLabel {
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

struct BoardFeatureVector {
  private var array: [Bool]

  var label: BoardFeatureLabel? {
    if array == [true, false, false, false, false, false, false] {
      return .onePair
    }

    if array == [false, true, false, false, false, false, false] {
      return .twoPair
    }

    if array == [false, false, true, false, false, false, false] {
      return .threeToFlush
    }

    if array == [false, false, false, true, false, false, false] {
      return .threeToStraight
    }

    if array == [false, false, false, false, true, false, false] {
      fatalError()
    }

    if array == [false, false, false, false, false, true, false] {
      return .fourToFlush
    }

    if array == [false, false, false, false, false, false, true] {
      return .fourToStraight
    }

    if array == [false, false, true, true, false, false, false]
      || array == [false, false, true, false, false, false, true]
      || array == [false, false, false, true, false, true, false]
      || array == [false, false, false, false, false, true, true]
    {
      return .possibleStraightPossibleFlush
    }

    if array == [true, false, false, false, false, false, true] {
      return .fourToStraightOnePair
    }

    if array == [true, false, true, false, false, false, false]
      || array == [true, false, false, false, false, true, false]
    {
      return .possibleFlushOnePair
    }

    return nil
  }

  init(cards: [Card]) {
    var array = Array(
      repeating: false,
      count: BoardFeature.allCases.count
    )

    let boardEvaluator = BoardEvaluator()
    array[0] = boardEvaluator.hasOnePair(cards: cards)
    array[1] = boardEvaluator.hasTwoPair(cards: cards)
    array[2] =
      boardEvaluator.hasThreeToFlush(cards: cards)
      && !boardEvaluator.hasFourToFlush(cards: cards)
    array[3] =
      boardEvaluator.hasThreeToStraight(cards: cards)
      && !boardEvaluator.hasFourToStraight(cards: cards)
    array[5] = boardEvaluator.hasFourToFlush(cards: cards)
    array[6] = boardEvaluator.hasFourToStraight(cards: cards)

    self.array = array
  }
}

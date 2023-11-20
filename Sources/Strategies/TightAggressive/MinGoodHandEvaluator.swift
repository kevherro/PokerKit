//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Evaluators
import Types

struct MinGoodHandEvaluator {
  private let factory = BoardTypeFactory()
  private let scorer = HandScorer()

  func isGoodEnough(
    holeCards: [Card],
    communityCards: [Card],
    street: Street
  ) -> Bool {
    let boardType = factory.makeBoardType(cards: communityCards)
    let minGoodHand = boardType.minGoodHand(for: street)

    guard let score = scorer.score(holeCards: holeCards, communityCards: communityCards) else {
      return false
    }

    return score >= minGoodHand
  }
}

struct HandScorer {
  func score(holeCards: [Card], communityCards: [Card]) -> MinGoodHand? {
    return scoreFlush(holeCards: holeCards, communityCards: communityCards)
      ?? scoreStraight(holeCards: holeCards, communityCards: communityCards)
      ?? scorePair(holeCards: holeCards, communityCards: communityCards)
  }

  func scoreFlush(holeCards: [Card], communityCards: [Card]) -> MinGoodHand? {
    let evaluator = FlushEvaluator()

    if evaluator.hasNutFlush(holeCards: holeCards, communityCards: communityCards) {
      return .nutFlush
    }

    if evaluator.hasFlush(holeCards: holeCards, communityCards: communityCards) {
      return .flush
    }

    return nil
  }

  func scoreStraight(holeCards: [Card], communityCards: [Card]) -> MinGoodHand? {
    let evaluator = StraightEvaluator()

    if evaluator.hasStraight(holeCards: holeCards, communityCards: communityCards) {
      return .straight
    }

    return nil
  }

  func scorePair(holeCards: [Card], communityCards: [Card]) -> MinGoodHand? {
    let evaluator = PairEvaluator()

    if evaluator.hasFullHouse(holeCards: holeCards, communityCards: communityCards) {
      return .fullHouse
    }

    if evaluator.hasSet(holeCards: holeCards, communityCards: communityCards) {
      return .trips
    }

    if evaluator.hasOverpair(holeCards: holeCards, communityCards: communityCards) {
      return .overpair
    }

    if evaluator.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards) {
      return .topPairTopKicker
    }

    if evaluator.hasTopPair(holeCards: holeCards, communityCards: communityCards) {
      return .topPair
    }

    if evaluator.hasSecondPair(holeCards: holeCards, communityCards: communityCards) {
      return .secondPair
    }

    return nil
  }
}

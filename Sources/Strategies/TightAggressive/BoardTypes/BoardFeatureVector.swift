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
  case threeToOpenEndedStraight
  case fourToFlush
  case fourToStraight
  case possibleStraightPossibleFlush
  case fourToStraightOnePair
  case possibleFlushOnePair
}

struct BoardFeatureVector {
  private let vector: [BoardFeature: Bool]

  var label: BoardFeatureLabel? {
    let features = reducedFeatures()

    if features == [.onePair] {
      return .onePair
    }

    if features == [.twoPair] {
      return .twoPair
    }

    if features == [.threeToFlush] {
      return .threeToFlush
    }

    if features == [.threeToOpenEndedStraight] {
      return .threeToOpenEndedStraight
    }

    if features == [.fourToFlush] {
      return .fourToFlush
    }

    if features == [.fourToStraight] {
      return .fourToStraight
    }

    if features == [.fourToStraight, .onePair] {
      return .fourToStraightOnePair
    }

    if features == [.onePair, .threeToFlush]
      || features == [.onePair, .fourToFlush]
    {
      return .possibleFlushOnePair
    }

    if features == [.threeToOpenEndedStraight, .threeToFlush]
      || features == [.threeToOpenEndedStraight, .fourToFlush]
      || features == [.fourToStraight, .threeToFlush]
      || features == [.fourToStraight, .fourToFlush]
    {
      return .possibleStraightPossibleFlush
    }

    return nil
  }

  init(cards: [Card]) {
    let evaluator = BoardEvaluator()
    self.vector = [
      .onePair: evaluator.hasOnePair(cards: cards),
      .twoPair: evaluator.hasTwoPair(cards: cards),
      .threeToFlush: evaluator.hasThreeToFlush(cards: cards),
      .threeToOpenEndedStraight: evaluator.hasThreeToOpenEndedStraight(cards: cards),
      .fourToFlush: evaluator.hasFourToFlush(cards: cards),
      .fourToStraight: evaluator.hasFourToStraight(cards: cards),
    ]
  }

  // MARK: -

  private func reducedFeatures() -> Set<BoardFeature> {
    let features = vector.filter(\.value).map(\.key)
    var reducedFeatures = Set(features)

    if reducedFeatures.contains(.threeToOpenEndedStraight)
      && reducedFeatures.contains(.fourToStraight)
    {
      reducedFeatures.remove(.threeToOpenEndedStraight)
    }

    if reducedFeatures.contains(.threeToFlush)
      && reducedFeatures.contains(.fourToFlush)
    {
      reducedFeatures.remove(.threeToFlush)
    }

    if reducedFeatures.contains(.onePair)
      && reducedFeatures.contains(.twoPair)
    {
      reducedFeatures.remove(.onePair)
    }

    return reducedFeatures
  }
}

//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

@testable import Strategies

public struct BoardFeatureVectorFactory {
  public init() {}

  public func makeFeatureVector(for label: BoardFeatureLabel) -> BoardFeatureVector {
    let cards = makeCards(for: label)
    return BoardFeatureVector(cards: cards)
  }

  // MARK: -

  private func makeCards(for label: BoardFeatureLabel) -> [Card] {
    switch label {
    case .onePair:
      return [
        card(.ace, .hearts),
        card(.ace, .diamonds),
        card(.king, .hearts),
      ]
    case .threeToOpenEndedStraight:
      return [
        card(.queen, .diamonds),
        card(.jack, .hearts),
        card(.ten, .spades),
      ]
    case .threeToFlush:
      return [
        card(.ace, .hearts),
        card(.ten, .hearts),
        card(.five, .hearts),
      ]
    case .possibleStraightPossibleFlush:
      return [
        card(.king, .hearts),
        card(.queen, .hearts),
        card(.jack, .hearts),
      ]
    case .fourToFlush:
      return [
        card(.ace, .hearts),
        card(.ten, .hearts),
        card(.seven, .hearts),
        card(.four, .hearts),
      ]
    case .fourToStraight:
      return [
        card(.king, .hearts),
        card(.queen, .diamonds),
        card(.jack, .hearts),
        card(.ten, .diamonds),
      ]
    case .fourToStraightOnePair:
      return [
        card(.king, .diamonds),
        card(.queen, .diamonds),
        card(.jack, .hearts),
        card(.ten, .hearts),
        card(.ten, .clubs),
      ]
    case .possibleFlushOnePair:
      return [
        card(.king, .hearts),
        card(.ten, .hearts),
        card(.five, .hearts),
        card(.five, .diamonds),
      ]
    case .twoPair:
      return [
        card(.ace, .hearts),
        card(.ace, .diamonds),
        card(.king, .hearts),
        card(.king, .diamonds),
      ]
    }
  }
}

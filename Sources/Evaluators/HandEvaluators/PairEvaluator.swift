//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct PairEvaluator {

  // MARK: Top Pair

  func hasTopPair(
    cards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Top Pair Top Kicker

  func hasTopPairTopKicker(
    cards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Second Pair

  func hasSecondPair(
    cards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Overpair

  func hasOverpair(
    cards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Two Pair

  func hasTwoPair(
    cards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Set

  func hasSet(
    cards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Three Of A Kind

  func hasThreeOfAKind(
    cards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Four Of A Kind

  func hasFourOfAKind(
    cards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Full House

  func hasFullHouse(
    cards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }
}

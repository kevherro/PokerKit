//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

/// `PairEvaluator` provides methods to evaluate specific paired hand types.
/// Each method independently checks for a particular hand type without considering
/// the overall strength of the hand in the context of NLHE poker hand rankings.
///
/// - Note: `PairEvaluator` does not rank hand strengths.
/// Therefore, it's possible for multiple methods to return `true` for the same hand.
/// For example, a hand could satisfy both `hasTopPair` and `hasTrips`.
public struct PairEvaluator {

  /// A hand of one pair, using the highest card on the board,
  /// regardless of how many times that card appears on the board.
  ///
  /// - Parameters:
  ///   - holeCards: The player's hole cards.
  ///   - communityCards: The community cards.
  ///
  /// - Returns: True if the player has top pair, false otherwise.
  public func hasTopPair(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    guard let highestRankInCommunityCards = highestRank(in: communityCards) else { return false }
    return holeCards.contains { $0.rank == highestRankInCommunityCards }
  }

  private func highestRank(in cards: [Card]) -> Rank? {
    let sortedRanks = cards.map(\.rank).sorted(by: >)
    return sortedRanks.first
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

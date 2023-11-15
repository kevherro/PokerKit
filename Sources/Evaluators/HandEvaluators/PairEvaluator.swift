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

  /// A hand of one pair, using the highest card on the board.
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
    guard check(holeCards: holeCards, communityCards: communityCards) else { return false }

    guard let highestRankInCommunity = highestRank(in: communityCards) else { return false }
    return holeCards.contains(where: { $0.rank == highestRankInCommunity })
  }

  /// A hand of one pair, using the highest card on the board,
  /// and holding the best possible kicker.
  ///
  /// - Parameters:
  ///   - holeCards: The player's hole cards.
  ///   - communityCards: The community cards.
  ///
  /// - Returns: True if the player has top pair top kicker, false otherwise.
  func hasTopPairTopKicker(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    guard check(holeCards: holeCards, communityCards: communityCards) else { return false }

    // Check if one of the hole cards forms the top pair with the board.
    guard let highestRankInCommunity = highestRank(in: communityCards) else { return false }
    if !holeCards.contains(where: { $0.rank == highestRankInCommunity }) {
      return false
    }

    // Determine the kicker,
    // which is the highest hole card not part of the top pair.
    guard let kicker = holeCards.first(where: { $0.rank != highestRankInCommunity })?.rank else {
      return false
    }

    // Find the highest card not on the board,
    // considering both the community and hole cards.
    guard
      let highestCardNotOnBoard = Rank
        .allCases
        .reversed()
        .first(where: { rank in !communityCards.contains(where: { $0.rank == rank }) })
    else {
      return false
    }

    // Check if the kicker is the highest possible kicker not represented on the board.
    return kicker == highestCardNotOnBoard
  }

  /// A hand of one pair, using the second highest card on the board.
  ///
  /// - Parameters:
  ///   - holeCards: The player's hole cards.
  ///   - communityCards: The community cards.
  ///
  /// - Returns: True if the player has second pair, false otherwise.
  public func hasSecondPair(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    guard check(holeCards: holeCards, communityCards: communityCards) else { return false }

    guard let secondHighestRankInCommunity = secondHighestRank(in: communityCards) else { return false }
    return holeCards.contains(where: { $0.rank == secondHighestRankInCommunity })
  }

  // MARK: Overpair

  func hasOverpair(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Two Pair

  func hasTwoPair(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Set

  func hasSet(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Three Of A Kind

  func hasThreeOfAKind(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Four Of A Kind

  func hasFourOfAKind(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: Full House

  func hasFullHouse(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return false
  }

  // MARK: -

  private func check(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return holeCards.count == 2
      && communityCards.count >= 3 && communityCards.count <= 5
  }

  private func highestRank(in cards: [Card]) -> Rank? {
    return cards.max(by: { $0.rank < $1.rank })?.rank
  }

  private func secondHighestRank(in cards: [Card]) -> Rank? {
    guard cards.count >= 2 else { return nil }
    let ranks = cards.map(\.rank).sorted(by: >)
    return ranks[1]
  }
}

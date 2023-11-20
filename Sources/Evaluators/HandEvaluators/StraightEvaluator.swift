//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

/// `StraightEvaluator` provides methods to evaluate specific straight hand types.
///
/// Each method independently checks for a particular hand type without considering
/// the overall strength of the hand in the context of NLHE poker hand rankings.
public struct StraightEvaluator {
  public init() {}

  /// A hand of five sequential cards, using zero, one, or two hole cards.
  ///
  /// - Parameters:
  ///   - holeCards: The player's hole cards.
  ///   - communityCards: The community cards.
  ///
  /// - Returns: True if the player has a straight, false otherwise.
  public func hasStraight(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    guard check(holeCards: holeCards, communityCards: communityCards) else { return false }
    let ranks = (holeCards + communityCards).ranks()
    return isNToStraight(5, ranks: ranks)
  }

  /// A hand of five sequential cards of the same suit,
  /// using zero, one, or two hole cards.
  ///
  /// - Parameters:
  ///   - holeCards: The player's hole cards.
  ///   - communityCards: The community cards.
  ///
  /// - Returns: True if the player has a straight flush, false otherwise.
  public func hasStraightFlush(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    guard check(holeCards: holeCards, communityCards: communityCards) else { return false }

    let suitsGroup = Dictionary(grouping: holeCards + communityCards, by: \.suit)
    guard let flushCards = suitsGroup.first(where: { $0.value.count >= 5 })?.value else {
      return false  // No flush.
    }

    let flushRanks = flushCards.ranks()
    return isNToStraight(5, ranks: flushRanks)
  }

  // MARK: -

  private func check(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return holeCards.count == 2
      && communityCards.count >= 3 && communityCards.count <= 5
      && Set(holeCards).count == holeCards.count
      && Set(communityCards).count == communityCards.count
  }
}

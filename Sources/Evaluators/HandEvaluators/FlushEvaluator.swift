//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

/// `FlushEvaluator` provides methods to evaluate specific flushed hand types.
///
/// Each method independently checks for a particular hand type without considering
/// the overall strength of the hand in the context of NLHE poker hand rankings.
public struct FlushEvaluator {
  public init() {}

  /// A hand of five cards of the same suit, using zero, one, or two hole cards.
  ///
  /// - Parameters:
  ///   - holeCards: The player's hole cards.
  ///   - communityCards: The community cards.
  ///
  /// - Returns: True if the player has a flush, false otherwise.
  public func hasFlush(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    guard check(holeCards: holeCards, communityCards: communityCards) else { return false }
    let histogram = (holeCards + communityCards).suitHistogram()
    return histogram.values.contains(where: { $0 >= 5 })
  }

  /// A hand of five cards of the same suit, using one or both hole cards,
  /// where one of the hole cards is the Ace of the flush suit.
  ///
  /// - Parameters:
  ///   - holeCards: The player's hole cards.
  ///   - communityCards: The community cards.
  ///
  /// - Returns: True if the player has the nut flush, false otherwise.
  public func hasNutFlush(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    guard check(holeCards: holeCards, communityCards: communityCards) else { return false }
    let histogram = (holeCards + communityCards).suitHistogram()
    guard let flushSuit = histogram.first(where: { $0.value >= 5 })?.key else { return false }
    return holeCards.contains(where: { $0.rank == .ace && $0.suit == flushSuit })
  }

  /// A hand of Ten, Jack, Queen, King, and Ace of the same suit,
  /// using zero, one, or two hole cards.
  ///
  /// - Parameters:
  ///   - holeCards: The player's hole cards.
  ///   - communityCards: The community cards.
  ///
  /// - Returns: True if the player has a royal flush, false otherwise.
  public func hasRoyalFlush(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    guard check(holeCards: holeCards, communityCards: communityCards) else { return false }

    let suitsGroup = Dictionary(grouping: holeCards + communityCards, by: \.suit)
    guard let flushCards = suitsGroup.first(where: { $0.value.count >= 5 })?.value else {
      return false  // No flush.
    }

    let flushRanks = flushCards.ranks()
    let royalFlushRanks = Set([Rank.ten, .jack, .queen, .king, .ace])

    let intersection = Set(flushRanks).intersection(royalFlushRanks)
    return intersection.count >= 5
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

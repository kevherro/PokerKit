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

  // MARK: -

  private func check(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return holeCards.count == 2
      && communityCards.count >= 3 && communityCards.count <= 5
  }
}

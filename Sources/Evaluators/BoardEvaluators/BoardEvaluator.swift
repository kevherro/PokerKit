//===----------------------------------------------------------------------===//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

/// `BoardEvaluator` provides methods to evaluate specific board features.
///
/// Each method independently checks for a particular board feature,
/// without considering its overall texture.
public struct BoardEvaluator {
  public init() {}

  /// Checks if any three cards on the board can potentially form a straight.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential straight using three cards, false otherwise.
  public func hasThreeToStraight(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    let ranks = cards.ranks()
    return !isNToStraight(5, ranks: ranks) && isNToStraight(3, ranks: ranks)
  }

  /// Checks if any four cards on the board can potentially form a straight.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential straight using four cards, false otherwise.
  public func hasFourToStraight(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    let ranks = cards.ranks()
    return !isNToStraight(5, ranks: ranks) && isNToStraight(4, ranks: ranks)
  }

  /// Checks if any three cards on the board can potentially form a flush.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential flush using three cards, false otherwise.
  public func hasThreeToFlush(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return isNToFlush(3, cards: cards)
  }

  /// Checks if any four cards on the board can potentially form a flush.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential flush using four cards, false otherwise.
  public func hasFourToFlush(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return isNToFlush(4, cards: cards)
  }

  /// Checks if the board has exactly one pair.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if the board has exactly one pair, false otherwise.
  public func hasOnePair(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return nPairs(cards: cards) == 1
  }

  /// Checks if the board has exactly two pairs.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if the board has exactly two pairs, false otherwise.
  public func hasTwoPair(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return nPairs(cards: cards) == 2
  }

  /// Checks if the board contains an Ace.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if the board is Ace high, false otherwise.
  public func isAceHigh(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return cards.contains(where: { $0.rank == .ace })
  }

  // MARK: -

  private func check(_ cards: [Card]) -> Bool {
    return cards.count >= 3 && cards.count <= 5
      && Set(cards).count == cards.count
  }

  private func isNToFlush(
    _ n: Int,
    cards: [Card]
  ) -> Bool {
    let suitHistogram = cards.suitHistogram()
    return suitHistogram.values.contains(n)
  }

  private func nPairs(cards: [Card]) -> Int {
    let rankHistogram = cards.rankHistogram()
    return rankHistogram.values.filter { $0 == 2 }.count
  }
}

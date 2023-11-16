//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

/// `BoardEvaluator` provides methods to evaluate specific board features.
/// Each method independently checks for a particular board feature,
/// without considering the overall texture of the board.
/// Therefore, it's possible for multiple methods to return `true` for the same board.
struct BoardEvaluator {
  private let possibleStraights: [Set<Rank>] = [
    [Rank.ace, .two, .three, .four, .five],
    [Rank.two, .three, .four, .five, .six],
    [Rank.three, .four, .five, .six, .seven],
    [Rank.four, .five, .six, .seven, .eight],
    [Rank.five, .six, .seven, .eight, .nine],
    [Rank.six, .seven, .eight, .nine, .ten],
    [Rank.seven, .eight, .nine, .ten, .jack],
    [Rank.eight, .nine, .ten, .jack, .queen],
    [Rank.nine, .ten, .jack, .queen, .king],
    [Rank.ten, .jack, .queen, .king, .ace],
  ]

  /// Checks if any three cards on the board can potentially form a straight.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential straight, false otherwise.
  @inlinable
  public func hasThreeToStraight(cards: [Card]) -> Bool {
    guard cards.count >= 3, cards.count <= 5 else { return false }

    let uniqueRanks = Set(cards.ranks())

    return !isNToStraight(5, ranks: uniqueRanks)
      && isNToStraight(3, ranks: uniqueRanks)
  }

  @inlinable
  public func hasThreeToOpenEndedStraight(cards: [Card]) -> Bool {
    return false
  }

  /// Checks if any four cards on the board can potentially form a straight.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential straight, false otherwise.
  @inlinable
  public func hasFourToStraight(cards: [Card]) -> Bool {
    guard cards.count >= 3, cards.count <= 5 else { return false }

    let uniqueRanks = Set(cards.ranks())

    return !isNToStraight(5, ranks: uniqueRanks)
      && isNToStraight(4, ranks: uniqueRanks)
  }

  /// Checks if any three cards on the board can potentially form a flush.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential flush, false otherwise.
  @inlinable
  public func hasThreeToFlush(cards: [Card]) -> Bool {
    guard cards.count >= 3, cards.count <= 5 else { return false }

    return isNToFlush(3, cards: cards)
  }

  /// Checks if any four cards on the board can potentially form a flush.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential flush, false otherwise.
  @inlinable
  public func hasFourToFlush(cards: [Card]) -> Bool {
    guard cards.count >= 3, cards.count <= 5 else { return false }

    return isNToFlush(4, cards: cards)
  }

  @inlinable
  public func hasOnePair(cards: [Card]) -> Bool {
    return false
  }

  @inlinable
  public func hasTwoPair(cards: [Card]) -> Bool {
    return false
  }

  // MARK: -

  private func isNToStraight(
    _ n: Int,
    ranks: Set<Rank>
  ) -> Bool {
    for straight in possibleStraights {
      let intersection = ranks.intersection(straight)
      if intersection.count >= n {
        return true
      }
    }
    return false
  }

  private func isNToFlush(
    _ n: Int,
    cards: [Card]
  ) -> Bool {
    let uniqueCards = Set(cards)
    let suitHistogram = Array(uniqueCards).suitHistogram()
    return suitHistogram.values.contains(n)
  }
}

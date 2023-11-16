//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

/// `BoardEvaluator` provides methods to evaluate specific board features.
///
/// Each method independently checks for a particular board feature,
/// without considering the overall texture of the board.
/// Meaning, it's possible that multiple methods return `true` for the same board.
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
  /// - Returns: True if there is a potential straight using three cards, false otherwise.
  @inlinable
  public func hasThreeToStraight(cards: [Card]) -> Bool {
    guard check(cards) else { return false }

    let uniqueRanks = Set(cards.ranks())
    let isCompleteStraight = isNToStraight(5, ranks: uniqueRanks)
    let isThreeToStraight = isNToStraight(3, ranks: uniqueRanks)

    return !isCompleteStraight && isThreeToStraight
  }

  @inlinable
  public func hasThreeToOpenEndedStraight(cards: [Card]) -> Bool {
    return false
  }

  /// Checks if any four cards on the board can potentially form a straight.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential straight using four cards, false otherwise.
  @inlinable
  public func hasFourToStraight(cards: [Card]) -> Bool {
    guard check(cards) else { return false }

    let uniqueRanks = Set(cards.ranks())
    let isCompleteStraight = isNToStraight(5, ranks: uniqueRanks)
    let isFourToStraight = isNToStraight(4, ranks: uniqueRanks)

    return !isCompleteStraight && isFourToStraight
  }

  /// Checks if any three cards on the board can potentially form a flush.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential flush using three cards, false otherwise.
  @inlinable
  public func hasThreeToFlush(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return isNToFlush(3, cards: cards)
  }

  /// Checks if any four cards on the board can potentially form a flush.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential flush using four cards, false otherwise.
  @inlinable
  public func hasFourToFlush(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return isNToFlush(4, cards: cards)
  }

  /// Checks if the board has exactly one pair.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if the board has exactly one pair, false otherwise.
  @inlinable
  public func hasOnePair(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return nPairs(cards: cards) == 1
  }

  /// Checks if the board has exactly two pairs.
  ///
  /// - Parameter cards: An array of type `Card` that represents the cards on the board.
  ///
  /// - Returns: True if the board has exactly two pairs, false otherwise.
  @inlinable
  public func hasTwoPair(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return nPairs(cards: cards) == 2
  }

  // MARK: -

  private func check(_ cards: [Card]) -> Bool {
    return cards.count >= 3 && cards.count <= 5
      && Set(cards).count == cards.count
  }

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
    let suitHistogram = cards.suitHistogram()
    return suitHistogram.values.contains(n)
  }

  private func nPairs(cards: [Card]) -> Int {
    let rankHistogram = cards.rankHistogram()
    return rankHistogram.values.filter { $0 == 2 }.count
  }
}

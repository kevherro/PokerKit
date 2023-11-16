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
  private let straights: [Set<Rank>] = [
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

    // First, check for a complete straight.
    for straight in straights {
      if straight.isSubset(of: uniqueRanks) {
        return false  // Board contains a complete straight.
      }
    }

    // Then check for three to a straight.
    for straight in straights {
      let intersection = uniqueRanks.intersection(straight)
      if intersection.count >= 3 {
        return true
      }
    }

    return false
  }

  @inlinable
  public func hasThreeToOpenEndedStraight(cards: [Card]) -> Bool {
    return false
  }

  @inlinable
  public func hasFourToStraight(_ cards: [Card]) -> Bool {
    return false
  }

  @inlinable
  public func hasThreeToFlush(cards: [Card]) -> Bool {
    return false
  }

  @inlinable
  public func hasFourToFlush(cards: [Card]) -> Bool {
    return false
  }

  @inlinable
  public func hasOnePair(cards: [Card]) -> Bool {
    return false
  }

  @inlinable
  public func hasTwoPair(cards: [Card]) -> Bool {
    return false
  }
}

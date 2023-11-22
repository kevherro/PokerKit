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
  /// - Parameter cards: `Card` array that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential straight using three cards, false otherwise.
  public func hasThreeToStraight(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    let ranks = cards.ranks()
    return isNToStraight(3, ranks: ranks)
  }

  /// Checks if there are three cards on the board that give two ways to make a straight.
  ///
  /// - Parameter cards: `Card` array that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential open-ended straight using three cards,
  /// false otherwise.
  public func hasThreeToOpenEndedStraight(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    let frequencies = rankFrequencies(cards.ranks())
    for i in 2..<frequencies.count - 3 {
      let slice = frequencies[i...i + 2]
      let isSequential = slice.allSatisfy({ $0 })
      if isSequential {
        return true
      }
    }
    return false
  }

  /// Checks if any four cards on the board can potentially form a straight.
  ///
  /// - Parameter cards: `Card` array that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential straight using four cards,
  /// false otherwise.
  public func hasFourToStraight(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    let ranks = cards.ranks()
    return isNToStraight(4, ranks: ranks)
  }

  /// Checks if any three cards on the board can potentially form a flush.
  ///
  /// - Parameter cards: `Card` array that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential flush using three cards, false otherwise.
  public func hasThreeToFlush(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return isNToFlush(3, cards: cards)
  }

  /// Checks if any four cards on the board can potentially form a flush.
  ///
  /// - Parameter cards: `Card` array that represents the cards on the board.
  ///
  /// - Returns: True if there is a potential flush using four cards, false otherwise.
  public func hasFourToFlush(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return isNToFlush(4, cards: cards)
  }

  /// Checks if the board has exactly one pair.
  ///
  /// - Parameter cards: `Card` array that represents the cards on the board.
  ///
  /// - Returns: True if the board has one pair, false otherwise.
  public func hasOnePair(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return nPairs(cards: cards) >= 1
  }

  /// Checks if the board has exactly two pairs.
  ///
  /// - Parameter cards: `Card` array that represents the cards on the board.
  ///
  /// - Returns: True if the board has exactly two pairs, false otherwise.
  public func hasTwoPair(cards: [Card]) -> Bool {
    guard check(cards) else { return false }
    return nPairs(cards: cards) == 2
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

  private func rankFrequencies(_ ranks: [Rank]) -> [Bool] {
    var frequencies = Array(repeating: false, count: Rank.allCases.count + 3)
    frequencies[1] = ranks.contains(.ace)  // Ace low.
    for rank in ranks {
      frequencies[rank.rawValue + 1] = true
    }
    return frequencies
  }
}

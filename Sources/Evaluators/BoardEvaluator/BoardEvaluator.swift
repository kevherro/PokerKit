//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct BoardEvaluator {
  @inlinable
  func getFeatures(cards: [Card]) -> Set<BoardFeature> {
    guard cards.count >= 3 && cards.count <= 5 else { return [] }

    var features = Set<BoardFeature>()

    if hasThreeToOpenEndedStraight(cards) {
      features.insert(.threeToOpenEndedStraight)
    }

    if hasFourToStraight(cards) {
      features.insert(.fourToStraight)
    }

    if hasThreeToFlush(cards) {
      features.insert(.threeToFlush)
    }

    if hasFourToFlush(cards) {
      features.insert(.fourToFlush)
    }

    if hasOnePair(cards) {
      features.insert(.onePair)
    }

    if hasTwoPair(cards) {
      features.insert(.twoPair)
    }

    return features
  }

  // MARK: Possible Straight

  private func hasThreeToOpenEndedStraight(_ cards: [Card]) -> Bool {
    // Dedupe and sort the ranks.
    let sortedUniqueRanks = sortedUniqueRanks(cards)

    // We need at least three unique ranks to have three to an open-ended straight.
    guard sortedUniqueRanks.count >= 3 else { return false }

    // Helper function to check for straights.
    func isSequential(_ ranks: [Rank]) -> Bool {
      for i in 0..<ranks.count - 1 {
        if ranks[i].rawValue != ranks[i + 1].rawValue - 1 {
          return false
        }
      }
      return true
    }

    for i in 0..<sortedUniqueRanks.count - 2 {
      let slice = Array(sortedUniqueRanks[i...i + 2])
      if isSequential(slice) {
        let isLowOpenEnded = sortedUniqueRanks[i] >= .two
        let isHighOpenEnded = sortedUniqueRanks[i + 2] <= .king
        if isLowOpenEnded && isHighOpenEnded {
          return true
        }
      }
    }

    return false
  }

  private func hasFourToStraight(_ cards: [Card]) -> Bool {
    // Dedupe and sort the ranks.
    let sortedUniqueRanks = Set(sortedUniqueRanks(cards))

    // We need at least four unique ranks to have four to a straight.
    guard sortedUniqueRanks.count >= 3 else { return false }

    let straights: [Set<Rank>] = [
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

    for straight in straights {
      let missingRanks = straight.symmetricDifference(sortedUniqueRanks)
      if missingRanks.count == 1 {
        return true
      }
    }

    return false
  }

  private func sortedUniqueRanks(_ cards: [Card]) -> [Rank] {
    let ranks = cards.map(\.rank)
    let uniqueRanks = Set(ranks)
    return uniqueRanks.sorted(by: <)
  }

  // MARK: Possible Flush

  private func hasThreeToFlush(_ cards: [Card]) -> Bool {
    let suitHistogram = cards.suitHistogram()
    return suitHistogram.values.contains(where: { $0 == 3 })
  }

  private func hasFourToFlush(_ cards: [Card]) -> Bool {
    let suitHistogram = cards.suitHistogram()
    return suitHistogram.values.contains(where: { $0 == 4 })
  }

  // MARK: Pair

  private func hasOnePair(_ cards: [Card]) -> Bool {
    let rankHistogram = cards.rankHistogram()
    return rankHistogram.values.filter { $0 == 2 }.count == 1
  }

  private func hasTwoPair(_ cards: [Card]) -> Bool {
    let rankHistogram = cards.rankHistogram()
    return rankHistogram.values.filter { $0 == 2 }.count == 2
  }
}

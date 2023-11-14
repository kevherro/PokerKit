//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

public struct Card {
  public let rank: Rank
  public let suit: Suit

  public init(rank: Rank, suit: Suit) {
    self.rank = rank
    self.suit = suit
  }
}

extension Array where Element == Card {
  public func rankHistogram() -> [Rank: Int] {
    var histogram = [Rank: Int]()
    for card in self {
      histogram[card.rank, default: 0] += 1
    }
    return histogram
  }

  public func suitHistogram() -> [Suit: Int] {
    var histogram = [Suit: Int]()
    for card in self {
      histogram[card.suit, default: 0] += 1
    }
    return histogram
  }
}

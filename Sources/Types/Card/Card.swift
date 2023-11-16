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

  public init(
    rank: Rank,
    suit: Suit
  ) {
    self.rank = rank
    self.suit = suit
  }
}

extension Card: Hashable {}

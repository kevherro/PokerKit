//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

/// Quickly create a Card.
public func card(
  _ rank: Rank,
  _ suit: Suit? = nil
) -> Card {
  let suit = suit ?? Suit.allCases.randomElement()!
  return Card(rank: rank, suit: suit)
}

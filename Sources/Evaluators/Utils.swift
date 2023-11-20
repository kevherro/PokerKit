//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

let possibleStraights: [Set<Rank>] = [
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

func isNToStraight(
  _ n: Int,
  ranks: [Rank]
) -> Bool {
  let uniqueRanks = Set(ranks)
  for straight in possibleStraights {
    let intersection = uniqueRanks.intersection(straight)
    if intersection.count >= n {
      return true
    }
  }
  return false
}

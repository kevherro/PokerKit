//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct BoardContext {
  let vector: BoardFeatureVector
  let isAceHigh: Bool
  let hasTJQK: Bool
}

struct BoardContextBuilder {
  func build(cards: [Card]) -> BoardContext {
    let vector = BoardFeatureVector(cards: cards)
    let isAceHigh = isAceHigh(cards: cards)
    let hasTJQK = hasTJQK(cards: cards)

    let context = BoardContext(
      vector: vector,
      isAceHigh: isAceHigh,
      hasTJQK: hasTJQK
    )

    return context
  }

  private func isAceHigh(cards: [Card]) -> Bool {
    let ranks = cards.map(\.rank)
    return ranks.contains(.ace)
  }

  private func hasTJQK(cards: [Card]) -> Bool {
    let ranks = cards.map(\.rank)
    return ranks.contains(.ten)
      && ranks.contains(.jack)
      && ranks.contains(.queen)
      && ranks.contains(.king)
  }
}

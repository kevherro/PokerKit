//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

protocol BoardTypeProtocol {
  func minGoodHand(for street: Street) -> MinGoodHand
}

struct BoardTypeFactory {
  func makeBoardType(cards: [Card]) -> BoardTypeProtocol {
    let context = BoardContextBuilder().build(cards: cards)

    if let label = context.vector.label {
      if isVeryScary(label: label) {
        return VeryScaryBoard(context: context)
      } else {
        return ScaryBoard(context: context)
      }
    } else {
      return NonScaryBoard(context: context)
    }
  }

  private func isVeryScary(label: BoardFeatureLabel) -> Bool {
    return label == .possibleStraightPossibleFlush
      || label == .fourToFlush
      || label == .fourToStraight
      || label == .fourToStraightOnePair
      || label == .possibleFlushOnePair
      || label == .twoPair
  }
}

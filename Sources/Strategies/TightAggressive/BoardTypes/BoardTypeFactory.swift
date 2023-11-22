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
  private enum BoardTexture {
    case veryScary, scary, nonScary

    init(label: BoardFeatureLabel?) {
      switch label {
      case .onePair,
        .threeToStraight,
        .threeToFlush:
        self = .scary
      case .twoPair,
        .fourToStraight,
        .fourToFlush,
        .fourToStraightOnePair,
        .possibleFlushOnePair,
        .possibleStraightPossibleFlush:
        self = .veryScary
      default:
        self = .nonScary
      }
    }
  }

  func makeBoardType(cards: [Card]) -> BoardTypeProtocol {
    let context = BoardContextBuilder().build(cards: cards)
    let texture = BoardTexture(label: context.vector.label)

    switch texture {
    case .veryScary:
      return VeryScaryBoard(context: context)
    case .scary:
      return ScaryBoard(context: context)
    case .nonScary:
      return NonScaryBoard(context: context)
    }
  }
}

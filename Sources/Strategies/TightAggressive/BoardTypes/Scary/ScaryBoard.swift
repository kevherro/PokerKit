//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct ScaryBoard: BoardTypeProtocol {
  private let board: BoardTypeProtocol

  init(context: BoardContext) {
    let factory = ScaryBoardTypeFactory()
    self.board = factory.makeBoard(context: context)
  }

  func minGoodHand(for street: Street) -> MinGoodHand {
    return board.minGoodHand(for: street)
  }
}

struct ScaryBoardTypeFactory {
  func makeBoard(context: BoardContext) -> BoardTypeProtocol {
    let label = context.vector.label
    let isAceHigh = context.isAceHigh

    switch label {
    case .onePair:
      return ScaryBoard_OnePair(isAceHigh: isAceHigh)
    case .threeToOpenEndedStraight:
      return ScaryBoard_ThreeToOpenEndedStraight(isAceHigh: isAceHigh)
    case .threeToFlush:
      return ScaryBoard_ThreeToFlush(isAceHigh: isAceHigh)
    default:
      fatalError("N/A")
    }
  }
}

struct ScaryBoard_OnePair: BoardTypeProtocol {
  private let isAceHigh: Bool

  init(isAceHigh: Bool) {
    self.isAceHigh = isAceHigh
  }

  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      return .topPair
    case .turn:
      return isAceHigh ? .topPairTopKicker : .overpair
    case .river:
      return .trips
    }
  }
}

struct ScaryBoard_ThreeToOpenEndedStraight: BoardTypeProtocol {
  private let isAceHigh: Bool

  init(isAceHigh: Bool) {
    self.isAceHigh = isAceHigh
  }

  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      return .topPair
    case .turn:
      return isAceHigh ? .topPairTopKicker : .overpair
    case .river:
      return .straight
    }
  }
}

struct ScaryBoard_ThreeToFlush: BoardTypeProtocol {
  private let isAceHigh: Bool

  init(isAceHigh: Bool) {
    self.isAceHigh = isAceHigh
  }

  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      return .topPair
    case .turn:
      return isAceHigh ? .topPairTopKicker : .overpair
    case .river:
      return .flush
    }
  }
}

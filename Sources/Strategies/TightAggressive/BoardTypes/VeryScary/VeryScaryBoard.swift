//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct VeryScaryBoard: BoardTypeProtocol {
  private let board: BoardTypeProtocol

  init(context: BoardContext) {
    let factory = VeryScaryBoardTypeFactory()
    self.board = factory.makeBoard(context: context)
  }

  func minGoodHand(for street: Street) -> MinGoodHand {
    return board.minGoodHand(for: street)
  }
}

struct VeryScaryBoardTypeFactory {
  func makeBoard(context: BoardContext) -> BoardTypeProtocol {
    let features = context.features
    let hasTJQK = context.hasTJQK

    let isStraightPossible = isStraightPossible(features: features)
    let isFlushPossible = isFlushPossible(features: features)

    if isStraightPossible && isFlushPossible && !features.contains(.onePair) {
      return VeryScaryBoard_PossibleStraight_PossibleFlush()
    } else if features == [.fourToFlush] {
      return VeryScaryBoard_FourToFlush()
    } else if features == [.fourToStraight] {
      return VeryScaryBoard_FourToStraight(hasTJQK: hasTJQK)
    } else if features == [.fourToStraight, .onePair] {
      return VeryScaryBoard_FourToStraight_OnePair()
    } else if isFlushPossible && features.contains(.onePair) {
      return VeryScaryBoard_PossibleFlush_OnePair()
    } else if features == [.twoPair] {
      return VeryScaryBoard_TwoPair()
    } else {
      return VeryScaryBoard_Default()
    }
  }

  private func isStraightPossible(features: Set<BoardFeature>) -> Bool {
    return features.contains(.threeToStraight)
      || features.contains(.fourToStraight)
  }

  private func isFlushPossible(features: Set<BoardFeature>) -> Bool {
    return features.contains(.threeToFlush)
      || features.contains(.fourToFlush)
  }
}

struct VeryScaryBoard_PossibleStraight_PossibleFlush: BoardTypeProtocol {
  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      return .straight
    case .turn:
      return .flush
    case .river:
      return .secondNutFlush
    }
  }
}

struct VeryScaryBoard_FourToFlush: BoardTypeProtocol {
  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      fatalError("N/A")
    case .turn:
      return .secondNutFlush
    case .river:
      return .nutFlush
    }
  }
}

struct VeryScaryBoard_FourToStraight: BoardTypeProtocol {
  private let hasTJQK: Bool

  init(hasTJQK: Bool) {
    self.hasTJQK = hasTJQK
  }

  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      fatalError("N/A")
    case .turn:
      return hasTJQK ? .nutStraight : .straight
    case .river:
      return .bestStraightUsingOneHoleCard
    }
  }
}

struct VeryScaryBoard_FourToStraight_OnePair: BoardTypeProtocol {
  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      fatalError("N/A")
    case .turn:
      return .nutStraight
    case .river:
      return .fullHouse
    }
  }
}

struct VeryScaryBoard_PossibleFlush_OnePair: BoardTypeProtocol {
  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      fatalError("N/A")
    case .turn:
      return .nutFlush
    case .river:
      return .fullHouse
    }
  }
}

struct VeryScaryBoard_TwoPair: BoardTypeProtocol {
  func minGoodHand(for street: Street) -> MinGoodHand {
    switch street {
    case .flop:
      fatalError("N/A")
    case .turn:
      return .fullHouse
    case .river:
      return .bestFullHouseUsingOneHoleCard
    }
  }
}

struct VeryScaryBoard_Default: BoardTypeProtocol {
  func minGoodHand(for street: Street) -> MinGoodHand {
    fatalError()
  }
}

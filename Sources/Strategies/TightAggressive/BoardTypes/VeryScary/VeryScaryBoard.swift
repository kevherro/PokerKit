//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct VeryScaryBoard: BoardTypeProtocol {
  private let factory = VeryScaryBoardTypeFactory()

  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    let board = factory.makeBoard(from: context.features)
    return board.minGoodHand(for: context)
  }
}

struct VeryScaryBoardTypeFactory {
  func makeBoard(from features: Set<BoardFeature>) -> BoardTypeProtocol {
    var adjustedFeatures = features
    adjustedFeatures.remove(.aceHigh)

    let isStraightPossible = isStraightPossible(features: adjustedFeatures)
    let isFlushPossible = isFlushPossible(features: features)

    if isStraightPossible && isFlushPossible && !adjustedFeatures.contains(.onePair) {
      return VeryScaryBoard_PossibleStraight_PossibleFlush()
    } else if adjustedFeatures == [.fourToFlush] {
      return VeryScaryBoard_FourToFlush()
    } else if adjustedFeatures == [.fourToStraight] {
      return VeryScaryBoard_FourToStraight()
    } else if adjustedFeatures == [.fourToStraight, .onePair] {
      return VeryScaryBoard_FourToStraight_OnePair()
    } else if isFlushPossible && adjustedFeatures.contains(.onePair) {
      return VeryScaryBoard_PossibleFlush_OnePair()
    } else if adjustedFeatures == [.twoPair] {
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
  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    switch context.street {
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
  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    switch context.street {
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
  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    switch context.street {
    case .flop:
      fatalError("N/A")
    case .turn:
      fatalError("straight or nut straight on board of TJQK")
    case .river:
      return .bestStraightUsingOneHoleCard
    }
  }
}

struct VeryScaryBoard_FourToStraight_OnePair: BoardTypeProtocol {
  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    switch context.street {
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
  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    switch context.street {
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
  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    switch context.street {
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
  func minGoodHand(for context: BoardContext) -> MinGoodHand {
    fatalError()
  }
}

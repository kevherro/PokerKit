//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct StreetEvaluatorFactory {
  func makeStreetEvaluator(street: Street) -> StreetEvaluatorProtocol {
    switch street {
    case .flop:
      return FlopEvaluator()
    case .turn:
      return TurnEvaluator()
    case .river:
      return RiverEvaluator()
    }
  }
}

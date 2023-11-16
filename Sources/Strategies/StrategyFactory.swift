//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

protocol StrategyProtocol {}

struct StrategyFactory {
  func makeStrategy(_ strategy: Strategy) -> StrategyProtocol {
    switch strategy {
    case .tightAggressive:
      return TightAggressiveStrategy()
    }
  }
}

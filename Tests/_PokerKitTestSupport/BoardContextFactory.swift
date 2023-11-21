//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

@testable import Strategies

public struct BoardContextFactory {
  private let factory = BoardFeatureVectorFactory()

  public init() {}

  public func makeBoardContext(
    for label: BoardFeatureLabel,
    isAceHigh: Bool = false,
    hasTJQK: Bool = false
  ) -> BoardContext {
    let vector = factory.makeFeatureVector(for: label)
    let context = BoardContext(
      vector: vector,
      isAceHigh: isAceHigh,
      hasTJQK: hasTJQK
    )
    return context
  }
}

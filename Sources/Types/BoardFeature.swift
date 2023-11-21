//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

public enum BoardFeature: CaseIterable {
  case onePair,
    twoPair,
    threeToFlush,
    threeToStraight,
    threeToOpenEndedStraight,
    fourToFlush,
    fourToStraight
}

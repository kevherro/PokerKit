//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class MinGoodHandEvaluatorTests_FourToStraightOnePair: PokerKitTestCase {
  private let sut = MinGoodHandEvaluator()

  func testFourToStraightOnePair_river() {
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.queen, .spades),
      card(.jack, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .river)
    expectEqual(minGoodHand, MinGoodHand.fullHouse)
  }
}

//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class MinGoodHandEvaluatorTests_TwoPair: PokerKitTestCase {
  private let sut = MinGoodHandEvaluator()

  func testTwoPair_turn() {
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.king, .diamonds),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .turn)
    expectEqual(minGoodHand, MinGoodHand.fullHouse)
  }

  func testTwoPair_river() {
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.king, .diamonds),
      card(.five, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .river)
    expectEqual(minGoodHand, MinGoodHand.bestFullHouseUsingOneHoleCard)
  }
}

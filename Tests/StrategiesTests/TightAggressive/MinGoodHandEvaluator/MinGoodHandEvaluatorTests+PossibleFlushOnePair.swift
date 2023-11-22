//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class MinGoodHandEvaluatorTests_PossibleFlushOnePair: PokerKitTestCase {
  private let sut = MinGoodHandEvaluator()

  func testPossibleFlushOnePair_turn() {
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.ten, .hearts),
      card(.five, .hearts),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .turn)
    expectEqual(minGoodHand, MinGoodHand.nutFlush)
  }

  func testPossibleFlushOnePair_threeToFlush_river() {
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.ten, .hearts),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .river)
    expectEqual(minGoodHand, MinGoodHand.fullHouse)
  }

  func testPossibleFlushOnePair_fourToFlush_river() {
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.ten, .hearts),
      card(.five, .hearts),
      card(.two, .hearts),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .river)
    expectEqual(minGoodHand, MinGoodHand.fullHouse)
  }
}

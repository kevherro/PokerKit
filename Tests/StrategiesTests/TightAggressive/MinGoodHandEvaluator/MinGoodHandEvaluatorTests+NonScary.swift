//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class MinGoodHandEvaluatorTests_NonScary: PokerKitTestCase {
  private let sut = MinGoodHandEvaluator()

  func testNonScary_flop() {
    let communityCards = [
      card(.king, .hearts),
      card(.ten, .diamonds),
      card(.eight, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .flop)
    expectEqual(minGoodHand, MinGoodHand.secondPair)
  }

  func testNonScary_turn() {
    let communityCards = [
      card(.king, .hearts),
      card(.ten, .diamonds),
      card(.eight, .clubs),
      card(.five, .spades),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .turn)
    expectEqual(minGoodHand, MinGoodHand.topPair)
  }

  func testNonScary_river() {
    let communityCards = [
      card(.king, .hearts),
      card(.ten, .diamonds),
      card(.eight, .clubs),
      card(.five, .spades),
      card(.two, .hearts),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .river)
    expectEqual(minGoodHand, MinGoodHand.overpair)
  }

  func testNonScary_river_aceHigh() {
    let communityCards = [
      card(.ace, .hearts),
      card(.queen, .diamonds),
      card(.eight, .clubs),
      card(.six, .spades),
      card(.three, .hearts),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .river)
    expectEqual(minGoodHand, MinGoodHand.topPairTopKicker)
  }

}

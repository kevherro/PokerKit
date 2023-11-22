//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class MinGoodHandEvaluatorTests: PokerKitTestCase {
  private let sut = MinGoodHandEvaluator()

  // MARK: Non Scary

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

  // MARK: Scary

  func testScary_pair_flop() {
    let communityCards = [
      card(.king, .hearts),
      card(.king, .diamonds),
      card(.eight, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .flop)
    expectEqual(minGoodHand, MinGoodHand.topPair)
  }

  func testScary_threeToFlush_flop() {
    let communityCards = [
      card(.king, .hearts),
      card(.eight, .hearts),
      card(.five, .hearts),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .flop)
    expectEqual(minGoodHand, MinGoodHand.topPair)
  }

  func testScary_threeToOpenEndedStraight_flop() {
    let communityCards = [
      card(.king, .hearts),
      card(.queen, .diamonds),
      card(.jack, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .flop)
    expectEqual(minGoodHand, MinGoodHand.topPair)
  }

  func testScary_pair_turn() {
    let communityCards = [
      card(.king, .hearts),
      card(.king, .diamonds),
      card(.eight, .clubs),
      card(.five, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .turn)
    expectEqual(minGoodHand, MinGoodHand.overpair)
  }

  func testScary_threeToFlush_turn() {
    let communityCards = [
      card(.king, .hearts),
      card(.eight, .hearts),
      card(.five, .hearts),
      card(.two, .diamonds),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .turn)
    expectEqual(minGoodHand, MinGoodHand.overpair)
  }

  func testScary_threeToOpenEndedStraight_turn() {
    let communityCards = [
      card(.king, .hearts),
      card(.queen, .diamonds),
      card(.jack, .clubs),
      card(.two, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .turn)
    expectEqual(minGoodHand, MinGoodHand.overpair)
  }

  func testScary_turn_aceHigh() {
    let communityCards = [
      card(.ace, .hearts),
      card(.queen, .diamonds),
      card(.queen, .hearts),
      card(.two, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .turn)
    expectEqual(minGoodHand, MinGoodHand.topPairTopKicker)
  }

  func testScary_pair_river() {
    let communityCards = [
      card(.king, .hearts),
      card(.king, .diamonds),
      card(.eight, .clubs),
      card(.five, .clubs),
      card(.four, .hearts),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .river)
    expectEqual(minGoodHand, MinGoodHand.trips)
  }

  func testScary_threeToFlush_river() {
    let communityCards = [
      card(.king, .hearts),
      card(.ten, .diamonds),
      card(.eight, .hearts),
      card(.five, .hearts),
      card(.two, .diamonds),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .river)
    expectEqual(minGoodHand, MinGoodHand.flush)
  }

  func testScary_threeToOpenEndedStraight_river() {
    let communityCards = [
      card(.king, .hearts),
      card(.queen, .diamonds),
      card(.jack, .clubs),
      card(.five, .spades),
      card(.two, .clubs),
    ]
    let minGoodHand = sut.minGoodHand(communityCards: communityCards, street: .river)
    expectEqual(minGoodHand, MinGoodHand.straight)
  }
}
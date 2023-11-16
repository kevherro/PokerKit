//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Evaluators

final class StraightEvaluatorTests: PokerKitTestCase {
  private let sut = StraightEvaluator()

  // MARK: Straight

  func testStraight() {
    let holeCards = [card(.two, .hearts), card(.three, .hearts)]
    let communityCards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
    ]
    let hasStraight = sut.hasStraight(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasStraight)
  }

  func testStraight_communityCards() {
    let holeCards = [card(.jack, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
    ]
    let hasStraight = sut.hasStraight(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasStraight)
  }

  func testNoStraight() {
    let holeCards = [card(.jack, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
    ]
    let hasStraight = sut.hasStraight(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasStraight)
  }

  func testNoStraight_tooFewCards() {
    let holeCards = [card(.jack, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasStraight = sut.hasStraight(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasStraight)
  }

  func testNoStraight_tooManyCards() {
    let holeCards = [card(.jack, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let hasStraight = sut.hasStraight(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasStraight)
  }

  func testNoStraight_invalidDupes() {
    let holeCards = [card(.five, .hearts), card(.three, .hearts)]
    let communityCards = [
      card(.four, .hearts),
      card(.four, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
    ]
    let hasStraight = sut.hasStraight(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasStraight)
  }
}

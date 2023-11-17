//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Evaluators

final class BoardEvaluatorTests: PokerKitTestCase {
  private let sut = BoardEvaluator()

  // MARK: Three To A Straight

  func testHasThreeToStraight_middleSequential() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func testHasThreeToStraight_middleOneGap() {
    let cards = [
      card(.four, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func testHasThreeToStraight_aceLowSequential() {
    let cards = [
      card(.ace, .hearts),
      card(.two, .hearts),
      card(.three, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func testHasThreeToStraight_aceLowOneGap() {
    let cards = [
      card(.ace, .hearts),
      card(.three, .hearts),
      card(.four, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func testHasThreeToStraight_aceHighSequential() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .hearts),
      card(.queen, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func testHasThreeToStraight_aceHighOneGap() {
    let cards = [
      card(.ace, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func testNoThreeToStraight_boardHasStraight() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  func testNoThreeToStraight_noPotentialStraight() {
    let cards = [
      card(.four, .hearts),
      card(.eight, .hearts),
      card(.ten, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  func testNoThreeToStraight_duplicates() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  func testThreeToStraight_duplicates() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.five, .clubs),
      card(.six, .clubs),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func testNoThreeToStraight_tooFewCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .diamonds),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  func testNoThreeToStraight_tooManyCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .diamonds),
      card(.six, .diamonds),
      card(.eight, .diamonds),
      card(.nine, .diamonds),
      card(.ten, .diamonds),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  // MARK: Four To A Straight

  func testHasFourToStraight_middleSequential() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func testHasFourToStraight_middleOneGap() {
    let cards = [
      card(.three, .hearts),
      card(.four, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func testHasFourToStraight_aceLowSequential() {
    let cards = [
      card(.ace, .hearts),
      card(.two, .hearts),
      card(.three, .hearts),
      card(.four, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func testHasFourToStraight_aceLowOneGap() {
    let cards = [
      card(.ace, .hearts),
      card(.three, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func testHasFourToStraight_aceHighSequential() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func testHasFourToStraight_aceHighOneGap() {
    let cards = [
      card(.ace, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func testNoFourToStraight_boardHasStraight() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  func testNoFourToStraight_noPotentialStraight() {
    let cards = [
      card(.four, .hearts),
      card(.eight, .hearts),
      card(.ten, .hearts),
      card(.king, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  func testNoFourToStraight_duplicates() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.four, .spades),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  func testFourToStraight_duplicates() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .clubs),
      card(.six, .clubs),
      card(.seven, .clubs),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func testNoFourToStraight_tooFewCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .diamonds),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  func testNoFourToStraight_tooManyCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .diamonds),
      card(.six, .diamonds),
      card(.eight, .diamonds),
      card(.nine, .diamonds),
      card(.ten, .diamonds),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  // MARK: Three To Flush

  func testThreeToFlush() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectTrue(hasThreeToFlush)
  }

  func testNoThreeToFlush_invalidDupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectFalse(hasThreeToFlush)
  }

  func testNoThreeToFlush_tooFewFlushCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .diamonds),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectFalse(hasThreeToFlush)
  }

  func testNoThreeToFlush_tooFewCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectFalse(hasThreeToFlush)
  }

  func testNoThreeToFlush_tooManyCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectFalse(hasThreeToFlush)
  }

  // MARK: Four To Flush

  func testFourToFlush() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectTrue(hasFourToFlush)
  }

  func testNoFourToFlush_invalidDupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectFalse(hasFourToFlush)
  }

  func testNoFourToFlush_tooFewFlushCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .diamonds),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectFalse(hasFourToFlush)
  }

  func testNoFourToFlush_tooFewCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectFalse(hasFourToFlush)
  }

  func testNoFourToFlush_tooManyCards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectFalse(hasFourToFlush)
  }

  // MARK: One Pair

  func testOnePair() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectTrue(hasOnePair)
  }

  func testNoPair_tooManyPairs() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
      card(.five, .diamonds),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func testOnePair_tooFewCards() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func testOnePair_tooManyCards() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func testOnePair_invalidDupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func testOnePair_threeOfAKind() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.five, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func testOnePair_fourOfAKind() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.four, .spades),
      card(.five, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  // MARK: Two Pair

  func testTwoPair() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
      card(.five, .diamonds),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectTrue(hasTwoPair)
  }

  func testNoTwoPair_tooFewPairs() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func testTwoPair_tooFewCards() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func testTwoPair_tooManyCards() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func testTwoPair_invalidDupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func testTwoPair_threeOfAKind() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.five, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func testTwoPair_fourOfAKind() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.four, .spades),
      card(.five, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  // MARK: Ace High

  func testAceHigh() {
    let cards = [
      card(.ace, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
    ]
    let isAceHigh = sut.isAceHigh(cards: cards)
    expectTrue(isAceHigh)
  }

  func testNoAceHigh() {
    let cards = [
      card(.king, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
    ]
    let isAceHigh = sut.isAceHigh(cards: cards)
    expectFalse(isAceHigh)
  }

  func testAceHigh_tooFewCards() {
    let cards = [
      card(.ace, .hearts),
      card(.four, .diamonds),
    ]
    let isAceHigh = sut.isAceHigh(cards: cards)
    expectFalse(isAceHigh)
  }

  func testAceHigh_tooManyCards() {
    let cards = [
      card(.ace, .hearts),
      card(.four, .diamonds),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let isAceHigh = sut.isAceHigh(cards: cards)
    expectFalse(isAceHigh)
  }

  func testAceHigh_invalidDupes() {
    let cards = [
      card(.ace, .hearts),
      card(.four, .hearts),
      card(.four, .hearts),
    ]
    let isAceHigh = sut.isAceHigh(cards: cards)
    expectFalse(isAceHigh)
  }
}

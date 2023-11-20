//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Evaluators

final class FlushEvaluatorTests: PokerKitTestCase {
  private let sut = FlushEvaluator()

  // MARK: Flush

  func testHasFlush() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFlush)
  }

  func testHasFlush_allCards() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .hearts),
      card(.eight, .hearts),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFlush)
  }

  func testHasFlush_extraNonFlushCards() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .diamonds),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFlush)
  }

  func testHasFlush_inCommunityCards() {
    let holeCards = [card(.ace, .diamonds), card(.king, .diamonds)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .hearts),
      card(.eight, .hearts),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFlush)
  }

  func testNoFlush() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .diamonds),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFlush)
  }

  func testNoFlush_tooFewCards() {
    let hasFlush = sut.hasFlush(holeCards: [], communityCards: [])
    expectFalse(hasFlush)
  }

  func testNoFlush_tooManyCards() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .diamonds),
      card(.ten, .diamonds),
      card(.nine, .clubs),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFlush)
  }

  func testNoFlush_invalidDupes() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.queen, .hearts),
      card(.nine, .hearts),
      card(.ten, .hearts),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFlush)
  }

  // MARK: Nut Flush

  func testHasNutFlush() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
    ]
    let hasNutFlush = sut.hasNutFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasNutFlush)
  }

  func testHasNutFlush_allCards() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .hearts),
      card(.eight, .hearts),
    ]
    let hasNutFlush = sut.hasNutFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasNutFlush)
  }

  func testHasNutFlush_extraNonFlushCards() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .diamonds),
    ]
    let hasNutFlush = sut.hasNutFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasNutFlush)
  }

  func testNoNutFlush_inCommunityCards() {
    let holeCards = [card(.ace, .diamonds), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .hearts),
      card(.eight, .hearts),
    ]
    let hasNutFlush = sut.hasNutFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasNutFlush)
  }

  func testNoNutFlush() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .diamonds),
    ]
    let hasNutFlush = sut.hasNutFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasNutFlush)
  }

  func testNoNutFlush_tooFewCards() {
    let hasNutFlush = sut.hasNutFlush(holeCards: [], communityCards: [])
    expectFalse(hasNutFlush)
  }

  func testNoNutFlush_tooManyCards() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .diamonds),
      card(.ten, .diamonds),
      card(.nine, .clubs),
    ]
    let hasNutFlush = sut.hasNutFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasNutFlush)
  }

  func testNutNoFlush_invalidDupes() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.queen, .hearts),
      card(.nine, .hearts),
      card(.ten, .hearts),
    ]
    let hasNutFlush = sut.hasNutFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasNutFlush)
  }

  // MARK: Royal Flush

  func testRoyalFlush() {
    let holeCards = [card(.ten, .hearts), card(.jack, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.king, .hearts),
      card(.ace, .hearts),
    ]
    let hasRoyalFlush = sut.hasRoyalFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasRoyalFlush)
  }

  func testRoyalFlush_communityCards() {
    let holeCards = [card(.jack, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ten, .hearts),
      card(.jack, .hearts),
      card(.queen, .hearts),
      card(.king, .hearts),
      card(.ace, .hearts),
    ]
    let hasRoyalFlush = sut.hasRoyalFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasRoyalFlush)
  }

  func testNoRoyalFlush_straight() {
    let holeCards = [card(.ten, .hearts), card(.jack, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.king, .hearts),
      card(.ace, .diamonds),
    ]
    let hasRoyalFlush = sut.hasRoyalFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasRoyalFlush)
  }

  func testNoRoyalFlush_flush() {
    let holeCards = [card(.ten, .hearts), card(.jack, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.king, .hearts),
      card(.two, .hearts),
    ]
    let hasRoyalFlush = sut.hasRoyalFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasRoyalFlush)
  }

  func testNoRoyalFlush_tooFewCards() {
    let holeCards = [card(.jack, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.king, .hearts),
    ]
    let hasRoyalFlush = sut.hasRoyalFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasRoyalFlush)
  }

  func testNoRoyalFlush_tooManyCards() {
    let holeCards = [card(.jack, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.king, .hearts),
      card(.ace, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
      card(.seven, .hearts),
    ]
    let hasRoyalFlush = sut.hasRoyalFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasRoyalFlush)
  }

  func testNoStraightFlush_invalidDupes() {
    let holeCards = [card(.jack, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.king, .hearts),
      card(.king, .hearts),
      card(.ace, .hearts),
      card(.eight, .hearts),
    ]
    let hasRoyalFlush = sut.hasRoyalFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasRoyalFlush)
  }
}

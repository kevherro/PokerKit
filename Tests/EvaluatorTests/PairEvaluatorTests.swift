//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Evaluators

final class PairEvaluatorTests: PokerKitTestCase {
  private let sut = PairEvaluator()

  // MARK: Top Pair

  func testTopPair() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPair)
  }

  func testTopPair_fourOfAKind() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPair)
  }

  func testTopPair_set() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .spades),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPair)
  }

  func testTopPair_trips() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPair)
  }

  func testNoTopPair_noPair() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }

  func testNoTopPair_tooLow() {
    let holeCards = [card(.king, .diamonds), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }

  func testNoTopPair_pairedBoard() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }

  func testNoTopPair_pocketPair() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }

  func testNoTopPair_tooFewCards() {
    let hasTopPair = sut.hasTopPair(holeCards: [], communityCards: [])
    expectFalse(hasTopPair)
  }

  func testNoTopPair_tooManyCards() {
    let holeCards = [card(.king, .hearts), card(.two, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .clubs),
      card(.eight, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }

  func testNoTopPair_invalidDupes() {
    let holeCards = [card(.king, .hearts), card(.two, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.king, .diamonds),
      card(.queen, .hearts),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }

  // MARK: Top Pair Top Kicker

  func testTopPairTopKicker_aceKicker() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.king, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func testTopPairTopKicker_kingKicker() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func testTopPairTopKicker_queenKicker() {
    let holeCards = [card(.ace, .hearts), card(.queen, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func testTopPairTopKicker_fourOfAKind() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.ace, .diamonds),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func testTopPairTopKicker_trips() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func testNoTopPairTopKicker_set() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .spades),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func testNoTopPairTopKicker_noPair() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func testNoTopPairTopKicker_tooLow() {
    let holeCards = [card(.king, .diamonds), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func testNoTopPairTopKicker_pairedBoard() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func testNoTopPairTopKicker_pocketPair() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func testNoTopPairTopKicker_tooFewCards() {
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: [], communityCards: [])
    expectFalse(hasTopPairTopKicker)
  }

  func testNoTopPairTopKicker_tooManyCards() {
    let holeCards = [card(.king, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .clubs),
      card(.eight, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func testNoTopPairTopKicker_invalidDupes() {
    let holeCards = [card(.king, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.king, .diamonds),
      card(.queen, .hearts),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  // MARK: Second Pair

  func testSecondPair() {
    let holeCards = [card(.king, .hearts), card(.five, .diamonds)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSecondPair)
  }

  func testSecondPair_fourOfAKind() {
    let holeCards = [card(.king, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .spades),
      card(.king, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSecondPair)
  }

  func testSecondPair_set() {
    let holeCards = [card(.king, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .spades),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSecondPair)
  }

  func testSecondPair_trips() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.king, .clubs),
      card(.king, .spades),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSecondPair)
  }

  func testNoSecondPair_noPair() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  func testNoSecondPair_tooLow() {
    let holeCards = [card(.ten, .diamonds), card(.two, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  func testNoSecondPair_pairedBoard() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  func testNoSecondPair_pocketPair() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  func testNoSecondPair_tooFewCards() {
    let hasSecondPair = sut.hasSecondPair(holeCards: [], communityCards: [])
    expectFalse(hasSecondPair)
  }

  func testNoSecondPair_tooManyCards() {
    let holeCards = [card(.queen, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .clubs),
      card(.eight, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  func testNoSecondPair_invalidDupes() {
    let holeCards = [card(.queen, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.king, .diamonds),
      card(.queen, .hearts),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  // MARK: Overpair

  func testOverpair() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .hearts),
      card(.queen, .diamonds),
      card(.two, .clubs),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasOverpair)
  }

  func testNoOverpair_noPair() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasOverpair)
  }

  func testNoOverpair_tooLow() {
    let holeCards = [card(.two, .diamonds), card(.two, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasOverpair)
  }

  func testNoOverpair_pairedBoard() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasOverpair)
  }

  func testNoOverpair_tooFewCards() {
    let hasOverpair = sut.hasOverpair(holeCards: [], communityCards: [])
    expectFalse(hasOverpair)
  }

  func testNoOverpair_tooManyCards() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .clubs),
      card(.eight, .clubs),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasOverpair)
  }

  func testNoOverpair_invalidDupes() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.king, .diamonds),
      card(.queen, .hearts),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasOverpair)
  }

  // MARK: Set

  func testSet() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .hearts),
      card(.queen, .diamonds),
      card(.two, .clubs),
    ]
    let hasSet = sut.hasSet(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSet)
  }

  func testNoSet_noPair() {
    let holeCards = [card(.ace, .diamonds), card(.two, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasSet = sut.hasSet(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSet)
  }

  func testNoSet_fourOfAKind() {
    let holeCards = [card(.ace, .diamonds), card(.ace, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasSet = sut.hasSet(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSet)
  }

  func testNoSet_tooFewCards() {
    let hasSet = sut.hasSet(holeCards: [], communityCards: [])
    expectFalse(hasSet)
  }

  func testNoSet_tooManyCards() {
    let holeCards = [card(.king, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .clubs),
      card(.eight, .clubs),
    ]
    let hasSet = sut.hasSet(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSet)
  }

  func testNoSet_invalidDupes() {
    let holeCards = [card(.king, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.king, .diamonds),
      card(.queen, .hearts),
    ]
    let hasSet = sut.hasSet(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSet)
  }

  // MARK: Full House

  func testHasFullHouse_tripsFromHole() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .clubs),
      card(.king, .hearts),
    ]
    let hasFullHouse = sut.hasFullHouse(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFullHouse)
  }

  func testHasFullHouse_pairFromHole() {
    let holeCards = [card(.ace, .hearts), card(.five, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.king, .clubs),
      card(.king, .hearts),
    ]
    let hasFullHouse = sut.hasFullHouse(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFullHouse)
  }

  func testHasFullHouse_inCommunityCards() {
    let holeCards = [card(.five, .hearts), card(.three, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .clubs),
      card(.king, .hearts),
    ]
    let hasFullHouse = sut.hasFullHouse(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFullHouse)
  }

  func testNoFullHouse() {
    let holeCards = [card(.five, .hearts), card(.three, .diamonds)]
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .clubs),
      card(.king, .hearts),
    ]
    let hasFullHouse = sut.hasFullHouse(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFullHouse)
  }

  func testNoFullHouse_tooFewCards() {
    let holeCards = [card(.five, .hearts), card(.three, .diamonds)]
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
    ]
    let hasFullHouse = sut.hasFullHouse(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFullHouse)
  }

  func testNoFullHouse_tooManyCards() {
    let holeCards = [card(.five, .hearts), card(.three, .diamonds)]
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.king, .hearts),
      card(.king, .diamonds),
    ]
    let hasFullHouse = sut.hasFullHouse(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFullHouse)
  }

  func testNoFullHouse_invalidDupes() {
    let holeCards = [card(.five, .hearts), card(.three, .diamonds)]
    let communityCards = [
      card(.ace, .hearts),
      card(.ace, .hearts),
      card(.ace, .clubs),
      card(.ace, .spades),
    ]
    let hasFullHouse = sut.hasFullHouse(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFullHouse)
  }
}

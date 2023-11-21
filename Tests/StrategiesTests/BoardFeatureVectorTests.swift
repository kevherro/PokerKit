//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class BoardFeatureVectorTests: PokerKitTestCase {
  // MARK: Non Scary

  func testNil() {
    let cards = [
      card(.ace, .hearts),
      card(.ten, .diamonds),
      card(.five, .spades),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectNil(vector.label)
  }

  // MARK: Scary

  func testOnePair() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .onePair)
  }

  func testThreeToFlush() {
    let cards = [
      card(.ace, .hearts),
      card(.ten, .hearts),
      card(.five, .hearts),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .threeToFlush)
  }

  func testThreeToStraight() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .diamonds),
      card(.jack, .hearts),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .threeToStraight)
  }

  // MARK: Very Scary

  func testTwoPair() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.king, .diamonds),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .twoPair)
  }

  func testFourToFlush() {
    let cards = [
      card(.ace, .hearts),
      card(.ten, .hearts),
      card(.seven, .hearts),
      card(.four, .hearts),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .fourToFlush)
  }

  func testFourToStraight() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .diamonds),
      card(.jack, .hearts),
      card(.ten, .diamonds),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .fourToStraight)
  }

  func testPossibleStraightPossibleFlush_threeToStraight_threeToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .possibleStraightPossibleFlush)
  }

  func testPossibleStraightPossibleFlush_threeToStraight_fourToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.five, .hearts),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .possibleStraightPossibleFlush)
  }

  func testPossibleStraightPossibleFlush_fourToStraight_threeToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .diamonds),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .possibleStraightPossibleFlush)
  }

  func testPossibleStraightPossibleFlush_fourToFlush_fourToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .possibleStraightPossibleFlush)
  }

  func testFourToStraight_onePair() {
    let cards = [
      card(.king, .diamonds),
      card(.queen, .diamonds),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.ten, .clubs),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .fourToStraightOnePair)
  }

  func testPossibleFlush_onePair_threeToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.ten, .hearts),
      card(.five, .hearts),
      card(.five, .diamonds),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .possibleFlushOnePair)
  }

  func testPossibleFlush_onePair_fourToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.ten, .hearts),
      card(.five, .hearts),
      card(.five, .diamonds),
      card(.two, .hearts),
    ]
    let vector = BoardFeatureVector(cards: cards)
    expectEqual(vector.label, .possibleFlushOnePair)
  }
}

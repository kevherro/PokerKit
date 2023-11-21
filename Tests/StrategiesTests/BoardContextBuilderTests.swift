//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class BoardContextBuilderTests: PokerKitTestCase {
  private let sut = BoardContextBuilder()

  // MARK: Non Scary

  func testNil() {
    let cards = [
      card(.ace, .hearts),
      card(.ten, .diamonds),
      card(.five, .spades),
    ]
    let context = sut.build(cards: cards)
    expectNil(context.featureSet)
  }

  // MARK: Scary

  func testOnePair() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .onePair)
  }

  func testThreeToFlush() {
    let cards = [
      card(.ace, .hearts),
      card(.ten, .hearts),
      card(.five, .hearts),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .threeToFlush)
  }

  func testThreeToStraight() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .diamonds),
      card(.jack, .hearts),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .threeToStraight)
  }

  // MARK: Very Scary

  func testTwoPair() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.king, .diamonds),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .twoPair)
  }

  func testFourToFlush() {
    let cards = [
      card(.ace, .hearts),
      card(.ten, .hearts),
      card(.seven, .hearts),
      card(.four, .hearts),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .fourToFlush)
  }

  func testFourToStraight() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .diamonds),
      card(.jack, .hearts),
      card(.ten, .diamonds),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .fourToStraight)
  }

  func testPossibleStraightPossibleFlush_threeToStraight_threeToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .possibleStraightPossibleFlush)
  }

  func testPossibleStraightPossibleFlush_threeToStraight_fourToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.five, .hearts),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .possibleStraightPossibleFlush)
  }

  func testPossibleStraightPossibleFlush_fourToStraight_threeToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .diamonds),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .possibleStraightPossibleFlush)
  }

  func testPossibleStraightPossibleFlush_fourToFlush_fourToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .possibleStraightPossibleFlush)
  }

  func testFourToStraight_onePair() {
    let cards = [
      card(.king, .diamonds),
      card(.queen, .diamonds),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.ten, .clubs),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .fourToStraightOnePair)
  }

  func testPossibleFlush_onePair_threeToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.ten, .hearts),
      card(.five, .hearts),
      card(.five, .diamonds),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .possibleFlushOnePair)
  }

  func testPossibleFlush_onePair_fourToFlush() {
    let cards = [
      card(.king, .hearts),
      card(.ten, .hearts),
      card(.five, .hearts),
      card(.five, .diamonds),
      card(.two, .hearts),
    ]
    let context = sut.build(cards: cards)
    expectEqual(context.featureSet, .possibleFlushOnePair)
  }
}

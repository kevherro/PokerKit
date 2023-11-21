//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class BoardTypeFactoryTests: PokerKitTestCase {
  private let sut = BoardTypeFactory()

  // MARK: Non Scary Board

  func testMakeBoardType_nonScaryBoard() {
    let cards = [
      card(.ace, .hearts),
      card(.queen, .diamonds),
      card(.eight, .clubs),
      card(.six, .spades),
      card(.three, .hearts),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is NonScaryBoard)
  }

  // MARK: Scary Board

  func testMakeBoardType_scaryBoard_onePair() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is ScaryBoard)
  }

  func testMakeBoardType_scaryBoard_threeToFlush() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .hearts),
      card(.nine, .hearts),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is ScaryBoard)
  }

  func testMakeBoardType_scaryBoard_threeToStraight() {
    let cards = [
      card(.five, .clubs),
      card(.four, .hearts),
      card(.three, .diamonds),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is ScaryBoard)
  }

  // MARK: Very Scary Board

  func testMakeBoardType_veryScaryBoard_possibleStraight_possibleFlush() {
    let cards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .hearts),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is VeryScaryBoard)
  }

  func testMakeBoardType_veryScaryBoard_fourToFlush() {
    let cards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.five, .hearts),
      card(.four, .hearts),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is VeryScaryBoard)
  }

  func testMakeBoardType_veryScaryBoard_fourToStraight() {
    let cards = [
      card(.queen, .hearts),
      card(.jack, .diamonds),
      card(.ten, .hearts),
      card(.nine, .diamonds),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is VeryScaryBoard)
  }

  func testMakeBoardType_veryScaryBoard_fourToStraight_onePair() {
    let cards = [
      card(.queen, .hearts),
      card(.jack, .diamonds),
      card(.ten, .hearts),
      card(.nine, .diamonds),
      card(.nine, .clubs),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is VeryScaryBoard)
  }

  func testMakeBoardType_veryScaryBoard_threeToFlush_onePair() {
    let cards = [
      card(.queen, .hearts),
      card(.nine, .hearts),
      card(.seven, .hearts),
      card(.seven, .diamonds),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is VeryScaryBoard)
  }

  func testMakeBoardType_veryScaryBoard_fourToFlush_onePair() {
    let cards = [
      card(.queen, .hearts),
      card(.nine, .hearts),
      card(.seven, .hearts),
      card(.seven, .diamonds),
      card(.two, .hearts),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is VeryScaryBoard)
  }

  func testMakeBoardType_veryScaryBoard_twoPair() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.king, .diamonds),
    ]
    let boardType = sut.makeBoardType(cards: cards)
    expectTrue(boardType is VeryScaryBoard)
  }
}

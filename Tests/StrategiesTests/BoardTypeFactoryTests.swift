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
}

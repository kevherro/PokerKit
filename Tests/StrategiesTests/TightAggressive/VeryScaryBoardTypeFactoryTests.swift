//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies
@testable import Types

final class VeryScaryBoardTypeFactoryTests: PokerKitTestCase {
  private let sut = VeryScaryBoardTypeFactory()

  func testPossibleStraightAndPossibleFlush() {
    let boardType = makeBoardType(for: .possibleStraightPossibleFlush)
    expectTrue(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  func testFourToFlush() {
    let boardType = makeBoardType(for: .fourToFlush)
    expectTrue(boardType is VeryScaryBoard_FourToFlush)
  }

  func testFourToStraight() {
    let boardType = makeBoardType(for: .fourToStraight)
    expectTrue(boardType is VeryScaryBoard_FourToStraight)
  }

  func testFourToStraight_onePair() {
    let boardType = makeBoardType(for: .fourToStraightOnePair)
    expectTrue(boardType is VeryScaryBoard_FourToStraight_OnePair)
  }

  func testPossibleFlush_onePair() {
    let boardType = makeBoardType(for: .possibleFlushOnePair)
    expectTrue(boardType is VeryScaryBoard_PossibleFlush_OnePair)
  }

  func testTwoPair() {
    let boardType = makeBoardType(for: .twoPair)
    expectTrue(boardType is VeryScaryBoard_TwoPair)
  }

  // MARK: -

  private func makeBoardType(for label: BoardFeatureLabel) -> BoardTypeProtocol {
    let context = BoardContextFactory().makeBoardContext(for: label)
    return sut.makeBoard(context: context)
  }
}

//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class VeryScaryBoardTypeFactoryTests: PokerKitTestCase {
  private let sut = VeryScaryBoardTypeFactory()

  func testPossibleStraightAndPossibleFlush() {
    let boardType = makeBoardType(featureSet: .possibleStraightPossibleFlush)
    expectTrue(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  func testFourToFlush() {
    let boardType = makeBoardType(featureSet: .fourToFlush)
    expectTrue(boardType is VeryScaryBoard_FourToFlush)
  }

  func testFourToStraight() {
    let boardType = makeBoardType(featureSet: .fourToStraight)
    expectTrue(boardType is VeryScaryBoard_FourToStraight)
  }

  func testFourToStraight_onePair() {
    let boardType = makeBoardType(featureSet: .fourToStraightOnePair)
    expectTrue(boardType is VeryScaryBoard_FourToStraight_OnePair)
  }

  func testPossibleFlush_onePair() {
    let boardType = makeBoardType(featureSet: .possibleFlushOnePair)
    expectTrue(boardType is VeryScaryBoard_PossibleFlush_OnePair)
  }

  func testTwoPair() {
    let boardType = makeBoardType(featureSet: .twoPair)
    expectTrue(boardType is VeryScaryBoard_TwoPair)
  }

  // MARK: -

  private func makeBoardType(featureSet: BoardFeatureSet) -> BoardTypeProtocol {
    let context = BoardContext(featureSet: featureSet, isAceHigh: false, hasTJQK: false)
    return sut.makeBoard(context: context)
  }
}

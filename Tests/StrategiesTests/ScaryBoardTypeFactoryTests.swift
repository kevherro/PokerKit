//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Strategies

final class ScaryBoardTypeFactoryTests: PokerKitTestCase {
  private let sut = ScaryBoardTypeFactory()

  func testOnePair() {
    let boardType = makeBoardType(featureSet: .onePair)
    expectTrue(boardType is ScaryBoard_OnePair)
  }

  func testThreeToStraight() {
    let boardType = makeBoardType(featureSet: .threeToStraight)
    expectTrue(boardType is ScaryBoard_ThreeToStraight)
  }

  func testThreeToFlush() {
    let boardType = makeBoardType(featureSet: .threeToFlush)
    expectTrue(boardType is ScaryBoard_ThreeToFlush)
  }

  // MARK: -

  private func makeBoardType(featureSet: BoardFeatureSet) -> BoardTypeProtocol {
    let context = BoardContext(featureSet: featureSet, isAceHigh: false, hasTJQK: false)
    return sut.makeBoard(context: context)
  }
}

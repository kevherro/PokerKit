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

final class ScaryBoardTypeFactoryTests: PokerKitTestCase {
  private let sut = ScaryBoardTypeFactory()

  func testOnePair() {
    let boardType = makeBoardType(for: .onePair)
    expectTrue(boardType is ScaryBoard_OnePair)
  }

  func testThreeToStraight() {
    let boardType = makeBoardType(for: .threeToOpenEndedStraight)
    expectTrue(boardType is ScaryBoard_ThreeToOpenEndedStraight)
  }

  func testThreeToFlush() {
    let boardType = makeBoardType(for: .threeToFlush)
    expectTrue(boardType is ScaryBoard_ThreeToFlush)
  }

  // MARK: -

  private func makeBoardType(for label: BoardFeatureLabel) -> BoardTypeProtocol {
    let context = BoardContextFactory().makeBoardContext(for: label)
    return sut.makeBoard(context: context)
  }
}

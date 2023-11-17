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

  // MARK: One Pair

  func testOnePair() {
    let features = Set([BoardFeature.onePair])
    let boardType = makeBoardType(features: features)
    expectTrue(boardType is ScaryBoard_OnePair)
  }

  // MARK: Three To Straight

  func testThreeToStraight() {
    let features = Set([BoardFeature.threeToStraight])
    let boardType = makeBoardType(features: features)
    expectTrue(boardType is ScaryBoard_ThreeToStraight)
  }

  // MARK: Three To Flush

  func testThreeToFlush() {
    let features = Set([BoardFeature.threeToFlush])
    let boardType = makeBoardType(features: features)
    expectTrue(boardType is ScaryBoard_ThreeToFlush)
  }

  // MARK: Invalid Feature Combinations

  func testInvalidFeatureCombinations() {
    let features = Set([BoardFeature.threeToFlush, .onePair])
    let boardType = makeBoardType(features: features)
    expectTrue(boardType is ScaryBoard_Default)
  }

  // MARK: -

  private func makeBoardType(features: Set<BoardFeature>) -> BoardTypeProtocol {
    let context = BoardContext(features: features, isAceHigh: false, hasTJQK: false)
    return sut.makeBoard(context: context)
  }
}

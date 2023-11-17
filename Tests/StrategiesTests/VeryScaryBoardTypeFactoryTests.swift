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

  // MARK: Possible Straight And Possible Flush

  func testPossibleStraightAndPossibleFlush_threeToFlush_threeToStraight() {
    let features = Set([BoardFeature.threeToFlush, .threeToStraight])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  func testPossibleStraightAndPossibleFlush_threeToFlush_threeToStraight_onePair() {
    let features = Set([BoardFeature.threeToFlush, .threeToStraight, .onePair])
    let boardType = sut.makeBoard(from: features)
    expectFalse(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  func testPossibleStraightAndPossibleFlush_threeToFlush_fourToStraight() {
    let features = Set([BoardFeature.threeToFlush, .fourToStraight])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  func testPossibleStraightAndPossibleFlush_threeToFlush_fourToStraight_onePair() {
    let features = Set([BoardFeature.threeToFlush, .fourToStraight, .onePair])
    let boardType = sut.makeBoard(from: features)
    expectFalse(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  func testPossibleStraightAndPossibleFlush_fourToFlush_threeToStraight() {
    let features = Set([BoardFeature.fourToFlush, .threeToStraight])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  func testPossibleStraightAndPossibleFlush_fourToFlush_threeToStraight_onePair() {
    let features = Set([BoardFeature.fourToFlush, .threeToStraight, .onePair])
    let boardType = sut.makeBoard(from: features)
    expectFalse(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  func testPossibleStraightAndPossibleFlush_fourToFlush_fourToStraight() {
    let features = Set([BoardFeature.fourToFlush, .fourToStraight])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  func testPossibleStraightAndPossibleFlush_fourToFlush_fourToStraight_onePair() {
    let features = Set([BoardFeature.fourToFlush, .fourToStraight, .onePair])
    let boardType = sut.makeBoard(from: features)
    expectFalse(boardType is VeryScaryBoard_PossibleStraight_PossibleFlush)
  }

  // MARK: Four To Flush

  func testFourToFlush() {
    let features = Set([BoardFeature.fourToFlush])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_FourToFlush)
  }

  // MARK: Four To Straight

  func testFourToStraight() {
    let features = Set([BoardFeature.fourToStraight])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_FourToStraight)
  }

  func testFourToStraight_threeToFlush() {
    let features = Set([BoardFeature.fourToStraight, .threeToFlush])
    let boardType = sut.makeBoard(from: features)
    expectFalse(boardType is VeryScaryBoard_FourToStraight)
  }

  func testFourToStraight_fourToFlush() {
    let features = Set([BoardFeature.fourToStraight, .fourToFlush])
    let boardType = sut.makeBoard(from: features)
    expectFalse(boardType is VeryScaryBoard_FourToStraight)
  }

  // MARK: Four To Straight And One Pair

  func testFourToStraight_onePair() {
    let features = Set([BoardFeature.fourToStraight, .onePair])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_FourToStraight_OnePair)
  }

  func testFourToStraight_onePair_threeToFlush() {
    let features = Set([BoardFeature.fourToStraight, .onePair, .threeToFlush])
    let boardType = sut.makeBoard(from: features)
    expectFalse(boardType is VeryScaryBoard_FourToStraight_OnePair)
  }

  func testFourToStraight_onePair_fourToFlush() {
    let features = Set([BoardFeature.fourToStraight, .fourToFlush])
    let boardType = sut.makeBoard(from: features)
    expectFalse(boardType is VeryScaryBoard_FourToStraight_OnePair)
  }

  // MARK: Possible Flush And One Pair

  func testThreeToFlush_onePair() {
    let features = Set([BoardFeature.threeToFlush, .onePair])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_PossibleFlush_OnePair)
  }

  func testFourToFlush_onePair() {
    let features = Set([BoardFeature.fourToFlush, .onePair])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_PossibleFlush_OnePair)
  }

  // MARK: Two Pair

  func testTwoPair() {
    let features = Set([BoardFeature.twoPair])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_TwoPair)
  }

  // MARK: Invalid Feature Combinations

  func testInvalidFeatureCombinations() {
    let features = Set([BoardFeature.twoPair, .fourToStraight])
    let boardType = sut.makeBoard(from: features)
    expectTrue(boardType is VeryScaryBoard_Default)
  }
}

//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Evaluators

final class FlushEvaluatorTests: PokerKitTestCase {
  private let sut = FlushEvaluator()

  // MARK: Flush

  func test_has_flush() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFlush)
  }

  func test_has_flush_extra_non_flush_cards() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .diamonds),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFlush)
  }

  func test_has_flush_in_community_cards() {
    let holeCards = [card(.ace, .diamonds), card(.king, .diamonds)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .hearts),
      card(.eight, .hearts),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFlush)
  }

  func test_no_flush() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .diamonds),
    ]
    let hasFlush = sut.hasFlush(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFlush)
  }

  func test_no_flush_too_few_cards() {
    let hasFlush = sut.hasFlush(holeCards: [], communityCards: [])
    expectFalse(hasFlush)
  }
}

//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Evaluators

final class PairEvaluatorTests: PokerKitTestCase {
  private let sut = PairEvaluator()

  // MARK: Top Pair

  func test_top_pair() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPair)
  }

  func test_top_pair_quads() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPair)
  }

  func test_top_pair_set() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .spades),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPair)
  }

  func test_top_pair_trips() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPair)
  }

  func test_no_top_pair_too_few_holeCards() {
    let hasTopPair = sut.hasTopPair(holeCards: [], communityCards: [])
    expectFalse(hasTopPair)
  }

  func test_no_top_pair_no_pair() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }

  func test_no_top_pair_too_low() {
    let holeCards = [card(.king, .diamonds), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }

  func test_no_top_pair_paired_board() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }

  func test_no_top_pair_pocket_pair() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPair)
  }
}

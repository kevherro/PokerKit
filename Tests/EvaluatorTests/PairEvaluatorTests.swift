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

  func test_no_top_pair_too_few_cards() {
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

  // MARK: Top Pair Top Kicker

  func test_top_pair_top_kicker_ace_kicker() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.king, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func test_top_pair_top_kicker_king_kicker() {
    let holeCards = [card(.ace, .hearts), card(.king, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func test_top_pair_top_kicker_queen_kicker() {
    let holeCards = [card(.ace, .hearts), card(.queen, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func test_top_pair_top_kicker_quads() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.ace, .diamonds),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func test_top_pair_top_kicker_trips() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasTopPairTopKicker)
  }

  func test_no_top_pair_top_kicker_set() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .spades),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func test_no_top_pair_top_kicker_too_few_cards() {
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: [], communityCards: [])
    expectFalse(hasTopPairTopKicker)
  }

  func test_no_top_pair_top_kicker_no_pair() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func test_no_top_pair_top_kicker_too_low() {
    let holeCards = [card(.king, .diamonds), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func test_no_top_pair_top_kicker_paired_board() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  func test_no_top_pair_top_kicker_pocket_pair() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.two, .clubs),
    ]
    let hasTopPairTopKicker = sut.hasTopPairTopKicker(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasTopPairTopKicker)
  }

  // MARK: Second Pair

  func test_second_pair() {
    let holeCards = [card(.king, .hearts), card(.five, .diamonds)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSecondPair)
  }

  func test_second_pair_quads() {
    let holeCards = [card(.king, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .spades),
      card(.king, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSecondPair)
  }

  func test_second_pair_set() {
    let holeCards = [card(.king, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .spades),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSecondPair)
  }

  func test_second_pair_trips() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.king, .clubs),
      card(.king, .spades),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSecondPair)
  }

  func test_no_second_pair_too_few_cards() {
    let hasSecondPair = sut.hasSecondPair(holeCards: [], communityCards: [])
    expectFalse(hasSecondPair)
  }

  func test_no_second_pair_no_pair() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  func test_no_second_pair_too_low() {
    let holeCards = [card(.ten, .diamonds), card(.two, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  func test_no_second_pair_paired_board() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasSecondPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  func test_no_second_pair_pocket_pair() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.two, .clubs),
    ]
    let hasSecondPair = sut.hasTopPair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSecondPair)
  }

  // MARK: Overpair

  func test_overpair() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.king, .hearts),
      card(.queen, .diamonds),
      card(.two, .clubs),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasOverpair)
  }

  func test_no_overpairpair_too_few_cards() {
    let hasOverpair = sut.hasOverpair(holeCards: [], communityCards: [])
    expectFalse(hasOverpair)
  }

  func test_no_overpair_no_pair() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.five, .hearts),
      card(.two, .clubs),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasOverpair)
  }

  func test_no_overpair_too_low() {
    let holeCards = [card(.two, .diamonds), card(.two, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasOverpair)
  }

  func test_no_overpair_paired_board() {
    let holeCards = [card(.king, .hearts), card(.ten, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasOverpair = sut.hasOverpair(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasOverpair)
  }

  // MARK: Set

  func test_set() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .hearts),
      card(.queen, .diamonds),
      card(.two, .clubs),
    ]
    let hasSet = sut.hasSet(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasSet)
  }

  func test_no_set_too_few_cards() {
    let hasSet = sut.hasSet(holeCards: [], communityCards: [])
    expectFalse(hasSet)
  }

  func test_no_set_no_pair() {
    let holeCards = [card(.ace, .diamonds), card(.two, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasSet = sut.hasSet(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSet)
  }

  func test_no_set_quads() {
    let holeCards = [card(.ace, .diamonds), card(.ace, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.two, .clubs),
    ]
    let hasSet = sut.hasSet(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasSet)
  }

  // MARK: Three Of A Kind

  func test_three_of_a_kind() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .diamonds),
      card(.two, .clubs),
    ]
    let hasThreeOfAKind = sut.hasThreeOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasThreeOfAKind)
  }

  func test_three_of_a_kind_two_board_pairs() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .diamonds),
      card(.two, .clubs),
      card(.two, .diamonds),
    ]
    let hasThreeOfAKind = sut.hasThreeOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasThreeOfAKind)
  }

  func test_three_of_a_kind_and_pair() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .diamonds),
      card(.king, .clubs),
    ]
    let hasThreeOfAKind = sut.hasThreeOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasThreeOfAKind)
  }

  func test_three_of_a_kind_two_threes_of_a_kind() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .diamonds),
      card(.king, .clubs),
      card(.king, .diamonds),
    ]
    let hasThreeOfAKind = sut.hasThreeOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasThreeOfAKind)
  }

  func test_no_three_of_a_kind_too_few_cards() {
    let hasThreeOfAKind = sut.hasThreeOfAKind(holeCards: [], communityCards: [])
    expectFalse(hasThreeOfAKind)
  }

  func test_no_three_of_a_kind_set() {
    let holeCards = [card(.ace, .diamonds), card(.ace, .hearts)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .hearts),
      card(.two, .clubs),
    ]
    let hasThreeOfAKind = sut.hasThreeOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasThreeOfAKind)
  }

  func test_no_three_of_a_kind_quads() {
    let holeCards = [card(.ace, .spades), card(.king, .hearts)]
    let communityCards = [
      card(.ace, .diamonds),
      card(.ace, .hearts),
      card(.ace, .clubs),
    ]
    let hasThreeOfAKind = sut.hasThreeOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasThreeOfAKind)
  }

  // MARK: Four Of A Kind

  func test_four_of_a_kind_one_hole_card() {
    let holeCards = [card(.ace, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .diamonds),
      card(.ace, .spades),
    ]
    let hasFourOfAKind = sut.hasFourOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFourOfAKind)
  }

  func test_four_of_a_kind_both_hole_cards() {
    let holeCards = [card(.ace, .hearts), card(.ace, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.king, .spades),
    ]
    let hasFourOfAKind = sut.hasFourOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFourOfAKind)
  }

  func test_four_of_a_kind_no_hole_card() {
    let holeCards = [card(.king, .hearts), card(.queen, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.ace, .hearts),
      card(.ace, .diamonds),
    ]
    let hasFourOfAKind = sut.hasFourOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFourOfAKind)
  }

  func test_four_of_a_kind_set() {
    let holeCards = [card(.king, .hearts), card(.king, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .clubs),
    ]
    let hasFourOfAKind = sut.hasFourOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFourOfAKind)
  }

  func test_four_of_a_kind_pair() {
    let holeCards = [card(.king, .hearts), card(.queen, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .clubs),
    ]
    let hasFourOfAKind = sut.hasFourOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectTrue(hasFourOfAKind)
  }

  func test_no_four_of_a_kind_too_few_cards() {
    let hasFourOfAKind = sut.hasFourOfAKind(holeCards: [], communityCards: [])
    expectFalse(hasFourOfAKind)
  }

  func test_no_four_of_a_kind_three_of_a_kind() {
    let holeCards = [card(.ace, .hearts), card(.queen, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.ace, .spades),
      card(.king, .clubs),
    ]
    let hasFourOfAKind = sut.hasFourOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFourOfAKind)
  }

  func test_no_four_of_a_kind_pair() {
    let holeCards = [card(.ace, .hearts), card(.queen, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .clubs),
      card(.ten, .spades),
    ]
    let hasFourOfAKind = sut.hasFourOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFourOfAKind)
  }

  func test_no_four_of_a_kind_junk() {
    let holeCards = [card(.queen, .hearts), card(.nine, .diamonds)]
    let communityCards = [
      card(.ace, .clubs),
      card(.king, .clubs),
      card(.ten, .spades),
    ]
    let hasFourOfAKind = sut.hasFourOfAKind(holeCards: holeCards, communityCards: communityCards)
    expectFalse(hasFourOfAKind)
  }
}

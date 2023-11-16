//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import _PokerKitTestSupport

@testable import Evaluators

final class BoardEvaluatorTests: PokerKitTestCase {
  private let sut = BoardEvaluator()

  // MARK: Three To A Straight

  func test_has_three_to_straight_middle_sequential() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func test_has_three_to_straight_middle_one_gap() {
    let cards = [
      card(.four, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func test_has_three_to_straight_ace_low_sequential() {
    let cards = [
      card(.ace, .hearts),
      card(.two, .hearts),
      card(.three, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func test_has_three_to_straight_ace_low_one_gap() {
    let cards = [
      card(.ace, .hearts),
      card(.three, .hearts),
      card(.four, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func test_has_three_to_straight_ace_high_sequential() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .hearts),
      card(.queen, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func test_has_three_to_straight_ace_high_one_gap() {
    let cards = [
      card(.ace, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func test_no_three_to_straight_board_has_straight() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  func test_no_three_to_straight_no_potential_straight() {
    let cards = [
      card(.four, .hearts),
      card(.eight, .hearts),
      card(.ten, .hearts),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  func test_no_three_to_straight_duplicates() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  func test_three_to_straight_duplicates() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.five, .clubs),
      card(.six, .clubs),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectTrue(hasThreeToStraight)
  }

  func test_no_three_to_straight_too_few_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .diamonds),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  func test_no_three_to_straight_too_many_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .diamonds),
      card(.six, .diamonds),
      card(.eight, .diamonds),
      card(.nine, .diamonds),
      card(.ten, .diamonds),
    ]
    let hasThreeToStraight = sut.hasThreeToStraight(cards: cards)
    expectFalse(hasThreeToStraight)
  }

  // MARK: Four To A Straight

  func test_has_four_to_straight_middle_sequential() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func test_has_four_to_straight_middle_one_gap() {
    let cards = [
      card(.three, .hearts),
      card(.four, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func test_has_four_to_straight_ace_low_sequential() {
    let cards = [
      card(.ace, .hearts),
      card(.two, .hearts),
      card(.three, .hearts),
      card(.four, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func test_has_four_to_straight_ace_low_one_gap() {
    let cards = [
      card(.ace, .hearts),
      card(.three, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func test_has_four_to_straight_ace_high_sequential() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func test_has_four_to_straight_ace_high_one_gap() {
    let cards = [
      card(.ace, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
      card(.ten, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func test_no_four_to_straight_board_has_straight() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  func test_no_four_to_straight_no_potential_straight() {
    let cards = [
      card(.four, .hearts),
      card(.eight, .hearts),
      card(.ten, .hearts),
      card(.king, .hearts),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  func test_no_four_to_straight_duplicates() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.four, .spades),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  func test_four_to_straight_duplicates() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .clubs),
      card(.six, .clubs),
      card(.seven, .clubs),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectTrue(hasFourToStraight)
  }

  func test_no_four_to_straight_too_few_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .diamonds),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  func test_no_four_to_straight_too_many_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .diamonds),
      card(.six, .diamonds),
      card(.eight, .diamonds),
      card(.nine, .diamonds),
      card(.ten, .diamonds),
    ]
    let hasFourToStraight = sut.hasFourToStraight(cards: cards)
    expectFalse(hasFourToStraight)
  }

  // MARK: Three To Flush

  func test_three_to_flush() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectTrue(hasThreeToFlush)
  }

  func test_no_three_to_flush_invalid_dupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectFalse(hasThreeToFlush)
  }

  func test_no_three_to_flush_too_few_flush_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .diamonds),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectFalse(hasThreeToFlush)
  }

  func test_no_three_to_flush_too_few_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectFalse(hasThreeToFlush)
  }

  func test_no_three_to_flush_too_many_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let hasThreeToFlush = sut.hasThreeToFlush(cards: cards)
    expectFalse(hasThreeToFlush)
  }

  // MARK: Four To Flush

  func test_four_to_flush() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectTrue(hasFourToFlush)
  }

  func test_no_four_to_flush_invalid_dupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectFalse(hasFourToFlush)
  }

  func test_no_four_to_flush_too_few_flush_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .diamonds),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectFalse(hasFourToFlush)
  }

  func test_no_four_to_flush_too_few_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectFalse(hasFourToFlush)
  }

  func test_no_four_to_flush_too_many_cards() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let hasFourToFlush = sut.hasFourToFlush(cards: cards)
    expectFalse(hasFourToFlush)
  }

  // MARK: One Pair

  func test_one_pair() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectTrue(hasOnePair)
  }

  func test_more_than_one_pair() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
      card(.five, .diamonds),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func test_one_pair_too_few_cards() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func test_one_pair_too_many_cards() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func test_one_pair_invalid_dupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func test_one_pair_three_of_a_kind() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.five, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  func test_one_pair_four_of_a_kind() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.four, .spades),
      card(.five, .hearts),
    ]
    let hasOnePair = sut.hasOnePair(cards: cards)
    expectFalse(hasOnePair)
  }

  // MARK: Two Pair

  func test_two_pair() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
      card(.five, .diamonds),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectTrue(hasTwoPair)
  }

  func test_fewer_than_two_pair() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func test_two_pair_too_few_cards() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func test_two_pair_too_many_cards() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.six, .hearts),
      card(.seven, .hearts),
      card(.eight, .hearts),
      card(.nine, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func test_two_pair_invalid_dupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .hearts),
      card(.five, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func test_two_pair_three_of_a_kind() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.five, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }

  func test_two_pair_four_of_a_kind() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.four, .spades),
      card(.five, .hearts),
    ]
    let hasTwoPair = sut.hasTwoPair(cards: cards)
    expectFalse(hasTwoPair)
  }
}

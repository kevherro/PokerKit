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
}

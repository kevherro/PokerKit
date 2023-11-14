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

  // MARK: Edge Cases

  func test_too_few_cards() {
    let features = sut.getFeatures(cards: [])
    expectTrue(features.isEmpty)
  }

  func test_too_many_cards() {
    let cards = Array(repeating: card(.ace, .hearts), count: 6)
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.isEmpty)
  }

  // MARK: One Pair

  func test_one_pair() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.onePair))
  }

  func test_no_one_pair() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .diamonds),
      card(.queen, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.onePair))
  }

  // MARK: Two Pair

  func test_two_pair() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.king, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.twoPair))
  }

  func test_no_two_pair() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .diamonds),
      card(.queen, .hearts),
      card(.jack, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.twoPair))
  }

  func test_two_pair_not_one_pair() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.king, .hearts),
      card(.king, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.twoPair) && !features.contains(.onePair))
  }

  // MARK: Three To Flush

  func test_three_to_flush() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .hearts),
      card(.queen, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.threeToFlush))
  }

  func test_no_three_to_flush() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .hearts),
      card(.queen, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.threeToFlush))
  }

  // MARK: Four To Flush

  func test_four_to_flush() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.fourToFlush))
  }

  func test_no_four_to_flush() {
    let cards = [
      card(.ace, .hearts),
      card(.king, .hearts),
      card(.queen, .hearts),
      card(.jack, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.fourToFlush))
  }

  // MARK: Three To Open-Ended Straight

  func test_no_three_to_open_ended_straight_too_low() {
    let cards = [
      card(.ace, .hearts),
      card(.two, .hearts),
      card(.three, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.threeToOpenEndedStraight))
  }

  func test_no_three_to_open_ended_straight_too_high() {
    let cards = [
      card(.queen, .hearts),
      card(.king, .hearts),
      card(.ace, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.threeToOpenEndedStraight))
  }

  func test_no_three_to_open_ended_straight_gap() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.seven, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.threeToOpenEndedStraight))
  }

  func test_three_to_open_ended_straight_two_low() {
    let cards = [
      card(.two, .hearts),
      card(.three, .hearts),
      card(.four, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.threeToOpenEndedStraight))
  }

  func test_three_to_open_ended_straight_king_high() {
    let cards = [
      card(.jack, .hearts),
      card(.queen, .hearts),
      card(.king, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.threeToOpenEndedStraight))
  }

  func test_three_to_open_ended_straight_middle() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.threeToOpenEndedStraight))
  }

  func test_three_to_open_ended_straight_middle_dupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.threeToOpenEndedStraight))
  }

  func test_no_three_to_open_ended_straight_too_few_unique_ranks() {
    let cards = [
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.four, .hearts),
      card(.five, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.fourToStraight))
  }

  // MARK: Four To Straight

  func test_four_to_straight() {
    let cards = [
      card(.four, .hearts),
      card(.five, .hearts),
      card(.six, .diamonds),
      card(.eight, .clubs),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.fourToStraight))
  }

  func test_four_to_straight_dupes() {
    let cards = [
      card(.four, .hearts),
      card(.four, .diamonds),
      card(.five, .hearts),
      card(.six, .diamonds),
      card(.eight, .clubs),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.fourToStraight))
  }

  func test_four_to_straight_ace_low() {
    let cards = [
      card(.ace, .hearts),
      card(.two, .hearts),
      card(.three, .diamonds),
      card(.five, .clubs),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.fourToStraight))
  }

  func test_no_four_to_straight_dupes() {
    let cards = [
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.five, .hearts),
      card(.six, .diamonds),
      card(.nine, .clubs),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.fourToStraight))
  }

  func test_no_four_to_straight_too_few_unique_ranks() {
    let cards = [
      card(.four, .diamonds),
      card(.four, .clubs),
      card(.four, .hearts),
      card(.six, .diamonds),
      card(.nine, .clubs),
    ]
    let features = sut.getFeatures(cards: cards)
    expectFalse(features.contains(.fourToStraight))
  }

  // MARK: Multiple Board Features

  func test_one_pair_and_three_to_flush() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.eight, .hearts),
      card(.five, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.onePair) && features.contains(.threeToFlush))
  }

  func test_one_pair_and_four_to_flush() {
    let cards = [
      card(.ace, .hearts),
      card(.ace, .diamonds),
      card(.eight, .hearts),
      card(.five, .hearts),
      card(.three, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(features.contains(.onePair) && features.contains(.fourToFlush))
  }

  func test_one_pair_and_three_to_open_ended_straight() {
    let cards = [
      card(.jack, .hearts),
      card(.jack, .diamonds),
      card(.ten, .hearts),
      card(.nine, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(
      features.contains(.onePair)
        && features.contains(.threeToOpenEndedStraight)
    )
  }

  func test_one_pair_and_four_to_straight() {
    let cards = [
      card(.jack, .hearts),
      card(.jack, .diamonds),
      card(.ten, .hearts),
      card(.nine, .diamonds),
      card(.seven, .clubs),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(
      features.contains(.onePair)
        && features.contains(.fourToStraight)
    )
  }

  func test_one_pair_and_three_to_flush_and_four_to_straight() {
    let cards = [
      card(.jack, .hearts),
      card(.jack, .diamonds),
      card(.ten, .hearts),
      card(.nine, .diamonds),
      card(.seven, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(
      features.contains(.onePair)
        && features.contains(.threeToFlush)
        && features.contains(.fourToStraight)
    )
  }

  func test_three_to_flush_and_three_to_open_ended_straight() {
    let cards = [
      card(.ten, .hearts),
      card(.nine, .hearts),
      card(.eight, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(
      features.contains(.threeToFlush)
        && features.contains(.threeToOpenEndedStraight)
    )
  }

  func test_three_to_flush_and_four_to_straight() {
    let cards = [
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .hearts),
      card(.seven, .diamonds),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(
      features.contains(.threeToFlush)
        && features.contains(.fourToStraight)
    )
  }

  func test_four_to_flush_and_three_to_open_ended_straight() {
    let cards = [
      card(.king, .hearts),
      card(.ten, .hearts),
      card(.nine, .hearts),
      card(.eight, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(
      features.contains(.fourToFlush)
        && features.contains(.threeToOpenEndedStraight)
    )
  }

  func test_four_to_flush_and_four_to_straight() {
    let cards = [
      card(.jack, .hearts),
      card(.ten, .hearts),
      card(.nine, .hearts),
      card(.seven, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(
      features.contains(.fourToFlush)
        && features.contains(.fourToStraight)
    )
  }

  func test_two_pair_and_three_to_flush() {
    let cards = [
      card(.jack, .hearts),
      card(.jack, .diamonds),
      card(.ten, .hearts),
      card(.ten, .diamonds),
      card(.seven, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(
      features.contains(.twoPair)
        && features.contains(.threeToFlush)
    )
  }

  func test_two_pair_and_three_to_open_ended_straight() {
    let cards = [
      card(.jack, .hearts),
      card(.jack, .diamonds),
      card(.ten, .clubs),
      card(.ten, .spades),
      card(.nine, .hearts),
    ]
    let features = sut.getFeatures(cards: cards)
    expectTrue(
      features.contains(.twoPair)
        && features.contains(.threeToOpenEndedStraight)
    )
  }
}

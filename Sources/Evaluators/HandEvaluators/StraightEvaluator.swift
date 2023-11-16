//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Algorithms
import Types

/// `StraightEvaluator` provides methods to evaluate specific straight hand types.
///
/// Each method independently checks for a particular hand type without considering
/// the overall strength of the hand in the context of NLHE poker hand rankings.
public struct StraightEvaluator {

  /// A hand of five sequential cards, using zero, one, or two hole cards.
  ///
  /// - Parameters:
  ///   - holeCards: The player's hole cards.
  ///   - communityCards: The community cards.
  ///
  /// - Returns: True if the player has a straight, false otherwise.
  public func hasStraight(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    guard check(holeCards: holeCards, communityCards: communityCards) else { return false }

    let ranks = (holeCards + communityCards).ranks()
    let sortedRankValues = ranks.map(\.rawValue).sorted()

    for chunk in sortedRankValues.chunks(ofCount: 5) {
      let slice = Array(chunk)
      if isSequential(slice) {
        return true
      }
    }

    return false
  }

  // MARK: -

  private func check(
    holeCards: [Card],
    communityCards: [Card]
  ) -> Bool {
    return holeCards.count == 2
      && communityCards.count >= 3 && communityCards.count <= 5
      && Set(holeCards).count == holeCards.count
      && Set(communityCards).count == communityCards.count
  }

  private func isSequential(_ sequence: [Int]) -> Bool {
    guard !sequence.isEmpty else { return false }
    for i in 0..<sequence.count - 1 {
      if sequence[i] != sequence[i + 1] - 1 {
        return false
      }
    }
    return true
  }
}

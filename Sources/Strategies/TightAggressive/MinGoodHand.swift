//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

enum MinGoodHand:
  Int, Comparable
{
  case secondPair = 0
  case topPair
  case topPairTopKicker
  case overpair
  case trips
  case straight
  case nutStraight
  case flush
  case secondNutFlush
  case nutFlush
  case fullHouse

  static func < (lhs: MinGoodHand, rhs: MinGoodHand) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}

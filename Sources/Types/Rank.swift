//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

public enum Rank:
  Int, CaseIterable, Comparable
{
  case two = 2
  case three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace

  public static func < (lhs: Rank, rhs: Rank) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
}

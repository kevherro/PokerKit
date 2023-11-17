//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct NonScaryBoard: BoardTypeProtocol {
  func minGoodHand(for street: Street) -> MinGoodHand {
    fatalError()
  }
}

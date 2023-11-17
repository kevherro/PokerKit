//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import Types

struct VeryScaryBoard: BoardTypeProtocol {
  func minGoodHand(for street: Street) -> MinGoodHand {
    fatalError()
  }
}

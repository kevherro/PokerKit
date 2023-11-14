//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import XCTest

open class PokerKitTestCase: XCTestCase {
  open var isAvailable: Bool {
    return true
  }

  open override func invokeTest() {
    guard isAvailable else {
      print("\(Self.self) unavailable. Skipping.")
      return
    }
    return super.invokeTest()
  }
}

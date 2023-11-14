//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import XCTest

public func expectFailure(
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  let message = message()
  XCTFail(
    TestContext.currentTrace(message),
    file: file,
    line: line
  )
  if trapping {
    fatalError(message, file: file, line: line)
  }
}

//===----------------------------------------------------------------------===//
//
// This source file is part of the PokerKit project.
//
// Copyright (c) 2023 Kevin Herro
//
//===----------------------------------------------------------------------===//

import XCTest

public final class TestContext {
  // FIXME: This should be a thread-local variable.
  internal static var _current: TestContext?
}

extension TestContext {
  public static func currentTrace(
    _ message: String = "",
    title: String = "Trace"
  ) -> String {
    return ""
  }
}

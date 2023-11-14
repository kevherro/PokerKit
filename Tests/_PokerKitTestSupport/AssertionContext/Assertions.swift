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

public func _expectFailure(
  _ diagnostic: String,
  _ message: () -> String,
  trapping: Bool,
  file: StaticString,
  line: UInt
) {
  let message = message()
  XCTFail(
    TestContext.currentTrace(
      """
      \(diagnostic)
      \(message)
      """
    ),
    file: file,
    line: line
  )
  if trapping {
    fatalError(message, file: file, line: line)
  }
}

public func expectTrue(
  _ value: Bool,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if value { return }
  _expectFailure(
    "'\(value)' is not true",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectFalse(
  _ value: Bool,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if !value { return }
  _expectFailure(
    "'\(value)' is not false",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectNil<T>(
  _ value: Optional<T>,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if value == nil { return }
  _expectFailure(
    "'\(value!)' is not nil",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectNotNil<T>(
  _ value: Optional<T>,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if value != nil { return }
  _expectFailure(
    "value is nil",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectEqual<T: Equatable>(
  _ left: T,
  _ right: T,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if left == right { return }
  _expectFailure(
    "'\(left)' is not equal to '\(right)'",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectEqual<T: Equatable>(
  _ left: T?,
  _ right: T?,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if left == right { return }
  let l = left.map { "\($0)" } ?? "nil"
  let r = right.map { "\($0)" } ?? "nil"
  _expectFailure(
    "'\(l)' is not equal to '\(r)'",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectNotEqual<T: Equatable>(
  _ left: T,
  _ right: T,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if left != right { return }
  _expectFailure(
    "'\(left)' is equal to '\(right)'",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectLessThan<T: Comparable>(
  _ left: T,
  _ right: T,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if left < right { return }
  _expectFailure(
    "'\(left)' is not less than '\(right)'",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectLessThanOrEqual<T: Comparable>(
  _ left: T,
  _ right: T,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if left <= right { return }
  _expectFailure(
    "'\(left)' is not less than or equal to '\(right)'",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectGreaterThan<T: Comparable>(
  _ left: T,
  _ right: T,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if left > right { return }
  _expectFailure(
    "'\(left)' is not greater than '\(right)'",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectGreaterThanOrEqual<T: Comparable>(
  _ left: T,
  _ right: T,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  if left >= right { return }
  _expectFailure(
    "'\(left)' is not less than or equal to '\(right)'",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

public func expectEquivalentElements<S1: Sequence, S2: Sequence>(
  _ left: S1,
  _ right: S2,
  by areEquivalent: (S1.Element, S2.Element) -> Bool,
  _ message: @autoclosure () -> String = "",
  trapping: Bool = false,
  file: StaticString = #file,
  line: UInt = #line
) {
  let left = Array(left)
  let right = Array(right)
  if left.elementsEqual(right, by: areEquivalent) { return }
  _expectFailure(
    "'\(left)' does not have equivalent elements to '\(right)'",
    message,
    trapping: trapping,
    file: file,
    line: line
  )
}

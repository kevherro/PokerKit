// swift-tools-version: 5.9

import PackageDescription

struct CustomTarget {
  enum Kind {
    case exported
    case hidden
    case test
    case testSupport
  }

  var kind: Kind
  var name: String
  var dependencies: [Target.Dependency]
  var directory: String
}

extension CustomTarget.Kind {
  func path(for name: String) -> String {
    switch self {
    case .exported, .hidden: return "Sources/\(name)"
    case .test, .testSupport: return "Tests/\(name)"
    }
  }
}

extension CustomTarget {
  static func target(
    kind: Kind,
    name: String,
    dependencies: [Target.Dependency] = [],
    directory: String? = nil
  ) -> CustomTarget {
    return CustomTarget(
      kind: kind,
      name: name,
      dependencies: dependencies,
      directory: directory ?? name
    )
  }

  func toTarget() -> Target {
    switch kind {
    case .exported, .hidden, .testSupport:
      return Target.target(
        name: name,
        dependencies: dependencies,
        path: kind.path(for: directory)
      )
    case .test:
      return Target.testTarget(
        name: name,
        dependencies: dependencies,
        path: kind.path(for: directory)
      )
    }
  }
}

let targets: [CustomTarget] = [
  .target(
    kind: .hidden,
    name: "Evaluators",
    dependencies: ["Types"]
  ),
  .target(
    kind: .exported,
    name: "Types"
  ),
  .target(
    kind: .testSupport,
    name: "_PokerKitTestSupport",
    dependencies: ["Types"]
  ),
  .target(
    kind: .test,
    name: "EvaluatorTests",
    dependencies: ["Evaluators", "_PokerKitTestSupport"]
  ),
  .target(
    kind: .exported,
    name: "PokerKit",
    dependencies: ["Types"]
  ),
  .target(
    kind: .exported,
    name: "Strategies",
    dependencies: ["Types"]
  ),
]

let _products: [Product] = [
  .library(
    name: "PokerKit",
    targets: ["PokerKit"]
  )
]

let _targets: [Target] = targets.map { $0.toTarget() }

let _platforms: [SupportedPlatform] = [
  .macOS(.v13),
  .iOS(.v16),
]

let _dependencies: [Package.Dependency] = [
  .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0")
]

let package = Package(
  name: "PokerKit",
  platforms: _platforms,
  products: _products,
  dependencies: _dependencies,
  targets: _targets
)

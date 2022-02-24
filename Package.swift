// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "DebugKit",
  platforms: [
    .iOS(.v12)
  ],
  products: [
    .library(
      name: "DebugKit",
      targets: ["DebugKit"]
    )
  ],
  dependencies: [],
  targets: [
    .target(name: "DebugKit")
  ]
)

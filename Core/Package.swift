// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "Data", targets: ["Data"]),
    .library(name: "Domain", targets: ["Domain"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Domain",
      dependencies: []
    ),
    .target(
      name: "Data",
      dependencies: ["Domain"]
    ),
  ]
)

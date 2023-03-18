// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "DesignSystem",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "DesignSystem", targets: ["DesignSystem"]),
  ],
  dependencies: [
    .package(path: "Core"),
  ],
  targets: [
    .target(
      name: "DesignSystem",
      dependencies: [
        .product(name: "Domain", package: "Core"),
        .product(name: "Utils", package: "Core"),
      ],
      resources: [.process("Resources")]
    ),
  ]
)

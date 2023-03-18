// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Features",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "MoviesFeature", targets: ["MoviesFeature"]),
  ],
  dependencies: [
    .package(path: "Core"),
    .package(path: "DesignSystem"),
  ],
  targets: [
    .target(
      name: "MoviesFeature",
      dependencies: [
        .product(name: "Data", package: "Core"),
        .product(name: "Utils", package: "Core"),
        .product(name: "Domain", package: "Core"),
        .product(name: "DesignSystem", package: "DesignSystem"),
      ]
    ),
  ]
)

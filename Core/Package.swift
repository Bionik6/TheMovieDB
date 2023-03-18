// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "Data", targets: ["Data"]),
    .library(name: "Utils", targets: ["Utils"]),
    .library(name: "Domain", targets: ["Domain"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Domain",
      dependencies: ["Utils"]
    ),
    .target(
      name: "Utils",
      dependencies: []
    ),
    .target(
      name: "Data",
      dependencies: ["Domain"]
    ),
  ]
)

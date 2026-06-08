// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "app_extensions",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "app_extensions", targets: ["app_extensions"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "app_extensions",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            path: "Sources/app_extensions",
            resources: []
        )
    ]
)

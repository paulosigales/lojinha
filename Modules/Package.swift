// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Modules",
            targets: ["Network"]),
    ],
    dependencies: [
    ],
    targets: [
        
        .target(
            name: "Network",
            dependencies: ["Domain"]),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"]),
        
        .target(
            name: "Domain",
            dependencies: []),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain"]),
    ]
)

// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Modules",
            targets: ["Presentation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0"))
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: ["Network","Domain","Kingfisher"]),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation"]),
        
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

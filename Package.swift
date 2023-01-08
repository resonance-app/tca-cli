// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "TcaCli",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-syntax.git", .upToNextMinor(from: "0.50700.0")),
        .package(url: "https://github.com/apple/swift-format.git", .upToNextMinor(from: "0.50700.0")),
        .package(url: "https://github.com/JohnSundell/Files.git", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        .executableTarget(
            name: "TcaCli",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
                .product(name: "SwiftFormat", package: "swift-format"),
                .product(name: "Files", package: "Files")
            ]
        ),
        .testTarget(
            name: "TcaCliTests",
            dependencies: ["TcaCli"]
        ),
    ]
)

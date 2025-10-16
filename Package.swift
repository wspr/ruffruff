// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "RuffRuff",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "RuffRuff",
            targets: ["RuffRuff"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RuffRuff",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "RuffRuffTests",
            dependencies: ["RuffRuff"]
        )
    ]
)

// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftLintPlugin",
    products: [
        .plugin(name: "SwiftLint", targets: ["SwiftLint"]),
        .plugin(name: "SwiftLintCommand", targets: ["SwiftLintCommand"])
    ],
    targets: [
        .plugin(
            name: "SwiftLint",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"]
        ),
        .plugin(
            name: "SwiftLintCommand",
            capability: .command(
                intent: .custom(
                    verb: "swiftlint",
                    description: "Execute SwiftLint."
                )
            ),
            dependencies: ["SwiftLintBinary"]
        ),
        .binaryTarget(
            name: "SwiftLintBinary",
            path: "EmbededBundles/SwiftLintBinary.artifactbundle.zip"
        )
    ]
)

import Foundation
import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {

    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let arguments = arguments(
            packageDirectory: context.package.directory.string,
            targetDirectory: target.directory.string,
            targetName: target.name
        )
        return [
            .buildCommand(
                displayName: "Running SwiftLint for \(target.name)",
                executable: try context.tool(named: "swiftlint").path,
                arguments: arguments,
                environment: [:]
            )
        ]
    }

    func arguments(packageDirectory: String, targetDirectory: String, targetName: String) -> [String] {
        var arguments = [
            "lint",
            "--no-cache"
        ]

        let lintConfigFilePath = [
            "\(packageDirectory)/.swiftlint-\(targetName).yml",
            "\(packageDirectory)/.swiftlint.yml"
        ].first(where: FileManager.default.fileExists)

        if let lintConfigFilePath {
            arguments.append(contentsOf: ["--config", lintConfigFilePath])
        }

        arguments.append(targetDirectory)
        return arguments
    }
}

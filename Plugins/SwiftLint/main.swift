import Foundation
import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {

    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let arguments = arguments(
            packageDirectory: context.package.directory.string,
            targetDirectory: target.directory.string
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

    func arguments(packageDirectory: String, targetDirectory: String) -> [String] {
        var arguments = [
            "lint",
            "--no-cache"
        ]

        let lintConfigFilePath = "\(packageDirectory)/.swiftlint.yml"
        if FileManager.default.fileExists(atPath: lintConfigFilePath) {
            arguments.append(
                contentsOf: ["--config", lintConfigFilePath]
            )
        }

        arguments.append(targetDirectory)
        return arguments
    }
}

import Foundation

// Configuration struct for DevOps pipeline parser
struct DevOpsPipelineParserConfig {
    let pipelineName: String
    let repositoryURL: String
    let branch: String
    let pipelineSteps: [PipelineStep]
    let environmentVariables: [String: String]
}

// Configuration struct for individual pipeline steps
struct PipelineStep {
    let stepName: String
    let stepType: StepType
    let dependencies: [String]
    let script: String
}

// Enum for step types
enum StepType: String, CaseIterable {
    case build
    case test
    case deploy
    case custom
}

// Sample configuration data
let config = DevOpsPipelineParserConfig(
    pipelineName: "Prototype Pipeline",
    repositoryURL: "https://github.com/username/repo.git",
    branch: "main",
    pipelineSteps: [
        PipelineStep(
            stepName: "Build App",
            stepType: .build,
            dependencies: [],
            script: "swift build"
        ),
        PipelineStep(
            stepName: "Run Tests",
            stepType: .test,
            dependencies: ["Build App"],
            script: "swift test"
        ),
        PipelineStep(
            stepName: "Deploy to Staging",
            stepType: .deploy,
            dependencies: ["Run Tests"],
            script: "fastlane deploy"
        )
    ],
    environmentVariables: [
        "API_KEY": "secret_key",
        "DATABASE_URL": "https://db.example.com"
    ]
)

// Sample parser function
func parsePipelineConfig(_ config: DevOpsPipelineParserConfig) {
    print("Parsing pipeline config...")
    print("Pipeline Name: \(config.pipelineName)")
    print("Repository URL: \(config.repositoryURL)")
    print("Branch: \(config.branch)")
    
    for step in config.pipelineSteps {
        print("Step: \(step.stepName) - \(step.stepType.rawValue)")
        print("  Dependencies: \(step.dependencies.joined(separator: ", "))")
        print("  Script: \(step.script)")
    }
    
    print("Environment Variables:")
    for (key, value) in config.environmentVariables {
        print("  \(key) = \(value)")
    }
}

// Run the parser
parsePipelineConfig(config)
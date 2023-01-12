import ArgumentParser

@main
struct Tca: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        commandName: "tca",
        abstract: "A utility to generate Swift source code for the TCA framework.",
        subcommands: [Feature.self]
    )
}

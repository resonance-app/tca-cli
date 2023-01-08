import ArgumentParser

@main
struct TcaCli: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        commandName: "tca",
        abstract: "A utility to generate Swift source code for the TCA framework.",
        subcommands: [Feature.self]
    )
}

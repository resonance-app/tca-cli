//
//  Feature.swift
//  
//
//  Created by Julian Gentges on 07.01.23.
//

import ArgumentParser

struct Feature: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Modify TCA features.",
        subcommands: [Create.self],
        defaultSubcommand: Create.self
    )
}

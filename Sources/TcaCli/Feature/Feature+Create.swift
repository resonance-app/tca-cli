//
//  Feature+Create.swift
//  
//
//  Created by Julian Gentges on 07.01.23.
//

import Foundation

import Files
import SwiftFormat
import SwiftFormatConfiguration
import ArgumentParser
import SwiftSyntaxBuilder
import SwiftSyntax

extension Feature {
    struct Create: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "create",
            abstract: "Generate the source code structure for a single TCA feature."
        )
        
        @Argument
        var name: String
        
        @Option
        var project: String?
        
        @Option
        var developerName: String?
        
        @Option
        var organisationName: String?
        
        private func commentText(builderName: String) -> String {
            let date = Date()
            let fullDateFormatter = DateFormatter()
            fullDateFormatter.dateStyle = .short
            fullDateFormatter.timeStyle = .none
            fullDateFormatter.calendar = .current
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            yearFormatter.calendar = .current
            
            let projectString = {
                guard let project = self.project else {
                    return ""
                }
                
                return "\n  \(project)\n"
            }()
            let developerNameFinal = developerName ?? NSFullUserName()
            let organisationNameFinal = organisationName ?? developerNameFinal
            let fullDateString = fullDateFormatter.string(from: date)
            let yearString = yearFormatter.string(from: date)
            
            return """
            
              \(builderName).swift\(projectString)
            
              Created by \(developerNameFinal) on \(fullDateString).
              Copyright © \(yearString) \(organisationNameFinal). All rights reserved.
            
            """
        }
        
        private static let config: Configuration = {
            var config = Configuration()
            config.indentation = .spaces(4)
            config.lineBreakBeforeControlFlowKeywords = true
            config.lineLength = 120
            config.tabWidth = 4
            config.respectsExistingLineBreaks = false
            return config
        }()
        
        mutating func run() throws {
            let featuresFolderName = "Features"
            let containsFolder = Folder.current.containsSubfolder(named: featuresFolderName)
            if !containsFolder {
                try Folder.current.createSubfolder(named: featuresFolderName)
            }
            let featuresFolder = try Folder.current.subfolder(named: featuresFolderName)
            let featureFolder = try featuresFolder.createSubfolder(named: name)
            let builders: [any NamedSourceBuilder.Type] = [StateBuilder.self, ActionBuilder.self, ReducerBuilder.self]
            
            for builderType in builders {
                let builder = builderType.init(name: name)
                let format = Format(indentWidth: 4)
                let syntax = SourceFileSyntax(
                    builder.source
                        .buildSyntax(
                            format: format,
                            leadingTrivia: .blockComment(commentText(builderName: builder.name))
                        )
                )!
                let formatter = SwiftFormatter(configuration: Self.config)
                var formattedSwift = ""
                try formatter.format(syntax: syntax, assumingFileURL: nil, to: &formattedSwift)
                let fileContents = formattedSwift.data(using: .utf8)
                try featureFolder.createFile(named: builder.name, contents: fileContents)
            }
        }
    }
}

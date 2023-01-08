//
//  ActionBuilder.swift
//  
//
//  Created by Julian Gentges on 08.01.23.
//

import SwiftSyntaxBuilder

struct ActionBuilder: NamedSourceBuilder {
    
    @FirstLetterUppercased
    private(set) var name: String
    
    var source: SourceFile {
        SourceFile {
            EnumDecl(
                identifier: name,
                inheritanceClause: TypeInheritanceClause {
                    InheritedType(
                        typeName: SimpleTypeIdentifier(name: .identifier("Equatable").withTrailingTrivia(.spaces(1))
                        )
                    )
                }
            )
        }
    }
    
    init(name: String) {
        self.name = "\(name)Action"
    }
}

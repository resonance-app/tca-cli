//
//  StateBuilder.swift
//  
//
//  Created by Julian Gentges on 08.01.23.
//

import SwiftSyntaxBuilder

struct StateBuilder: NamedSourceBuilder {
    
    @FirstLetterUppercased
    private(set) var name: String
    
    var source: SourceFile {
        SourceFile {
            StructDecl(
                identifier: name,
                inheritanceClause: TypeInheritanceClause {
                    InheritedType(
                        typeName: SimpleTypeIdentifier(
                            name: .identifier("Equatable").withTrailingTrivia(.spaces(1))
                        )
                    )
                }
            )
        }
    }
    
    init(name: String) {
        self.name = "\(name)State"
    }
}

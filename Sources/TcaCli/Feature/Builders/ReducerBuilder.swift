//
//  ReducerBuilder.swift
//  
//
//  Created by Julian Gentges on 07.01.23.
//

import SwiftSyntaxBuilder

struct ReducerBuilder: NamedSourceBuilder {
    
    @FirstLetterUppercased
    var name: String
    
    private static let typealiasIdentifiers = ["State", "Action"]
    
    private var functionParameters: [FunctionParameter] {
        [
            FunctionParameter(
                attributes: nil,
                firstName: .identifier("into").withTrailingTrivia(.spaces(1)),
                secondName: .identifier("state"),
                colon: .colon.withTrailingTrivia(.spaces(1)),
                type: AttributedType(
                    specifier: .inout,
                    attributes: nil,
                    baseType: SimpleTypeIdentifier(name: .identifier("State"))
                ),
                trailingComma: .comma.withTrailingTrivia(.spaces(1))
            ),
            FunctionParameter(
                attributes: nil,
                firstName: .identifier("action"),
                colon: .colon.withTrailingTrivia(.spaces(1)),
                type: SimpleTypeIdentifier("Action")
            )
        ]
    }
    
    private var functionReturnClause: ReturnClause {
        ReturnClause(
            arrow: .arrow.withLeadingTrivia(.spaces(1)),
            returnType: SimpleTypeIdentifier(
                name: .identifier("EffectTask"),
                genericArgumentClause: GenericArgumentClause(
                    leftAngleBracket: .leftAngle.withoutTrivia(),
                    rightAngleBracket: .rightAngle.withoutTrivia()
                ) {
                    GenericArgument(argumentType: SimpleTypeIdentifier("Action"))
                }
            )
        )
    }
    
    private var functionSignature: FunctionSignature {
        FunctionSignature(
            input: ParameterClause(parameterList: FunctionParameterList(functionParameters)),
            output: functionReturnClause
        )
    }
    
    private var switchCases: SwitchCase {
        SwitchCase(
            unknownAttr: Attribute(
                attributeName: .identifier("unknown"),
                tokenList: nil
            ),
            label: SwitchDefaultLabel(
                defaultKeyword: .default
                    .withLeadingTrivia(.spaces(1))
                    .withoutTrailingTrivia()
            )
        ) {
            ReturnStmt(expression: MemberAccessExpr(dot: .period, name: .identifier("none")))
        }
    }
    
    private var switchStatement: SwitchStmt {
        SwitchStmt(
            labelName: nil,
            expression: IdentifierExpr(identifier: .identifier("action")),
            leftBrace: .leftBrace.withLeadingTrivia(.spaces(1))
        ) {
            switchCases
        }
    }
    
    var source: SourceFile {
        SourceFile {
            StructDecl(
                identifier: name,
                inheritanceClause: TypeInheritanceClause {
                    InheritedType(typeName: SimpleTypeIdentifier("ReducerProtocol"))
                },
                membersBuilder: {
                    for identifier in Self.typealiasIdentifiers {
                        TypealiasDecl(
                            identifier: identifier,
                            initializer: TypeInitializerClause(value: SimpleTypeIdentifier("\(name)\(identifier)"))
                        )
                    }
                    
                    FunctionDecl(identifier: .identifier("reduce"), signature: functionSignature, bodyBuilder: {
                        switchStatement
                    })
                }
            )
        }
    }
}

//
//  SourceBuilder.swift
//  
//
//  Created by Julian Gentges on 08.01.23.
//

import SwiftSyntaxBuilder

protocol SourceBuilder {
    var source: SourceFile { get }
}

protocol NamedSourceBuilder: SourceBuilder {
    var name: String { get }
    
    init(name: String)
}

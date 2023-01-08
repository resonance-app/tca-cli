//
//  ActionBuilderTest.swift
//  
//
//  Created by Julian Gentges on 08.01.23.
//

import XCTest
import SwiftSyntaxBuilder

@testable import TcaCli

final class ActionBuilderTest: XCTestCase {

    func testBuilder_generatesExpectedSource_withName() throws {
        let builder = ActionBuilder(name: "Test")
        let format = Format(indentWidth: 4)
        let string = builder.source.buildSyntax(format: format).description
        let expected = """
        
        enum TestAction: Equatable {
        }
        """
        XCTAssertEqual(string, expected)
    }

}

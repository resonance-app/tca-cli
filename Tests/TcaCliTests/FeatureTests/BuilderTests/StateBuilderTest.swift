//
//  StateBuilderTest.swift
//  
//
//  Created by Julian Gentges on 08.01.23.
//

import XCTest
import SwiftSyntaxBuilder

@testable import TcaCli

final class StateBuilderTest: XCTestCase {

    func testBuilder_generatesExpectedSource_withName() throws {
        let builder = StateBuilder(name: "Test")
        let format = Format(indentWidth: 4)
        let string = builder.source.buildSyntax(format: format).description
        let expected = """
        
        import Foundation
        struct TestState: Equatable {
        }
        """
        XCTAssertEqual(string, expected)
    }

}

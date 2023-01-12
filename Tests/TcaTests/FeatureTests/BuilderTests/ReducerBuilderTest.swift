//
//  ReducerBuilderTest.swift
//  
//
//  Created by Julian Gentges on 08.01.23.
//

import XCTest
import SwiftSyntaxBuilder

@testable import Tca

final class ReducerBuilderTest: XCTestCase {

    func testBuilder_generatesExpectedSource_withName() throws {
        let builder = ReducerBuilder(name: "Test")
        let format = Format(indentWidth: 4)
        let string = builder.source.buildSyntax(format: format).description
        let expected = """
        
        import ComposableArchitecture
        struct Test: ReducerProtocol{
            typealias State = TestState
            typealias Action = TestAction
            func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
                switch action {
                @unknown default:
                    return .none
                }
            }
        }
        """
        
        XCTAssertEqual(string, expected)
    }

}

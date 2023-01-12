//
//  FirstLetterUppercased.swift
//  
//
//  Created by Julian Gentges on 07.01.23.
//

import Foundation

@propertyWrapper
struct FirstLetterUppercased {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.withFirstLetterUppercased()
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.withFirstLetterUppercased()
    }
}

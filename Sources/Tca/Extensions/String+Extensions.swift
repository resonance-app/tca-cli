//
//  String+Extensions.swift
//  
//
//  Created by Julian Gentges on 07.01.23.
//

import Foundation

extension String {
    func withFirstLetterUppercased() -> String {
        guard let firstLetter = first else {
            return self
        }
        
        return firstLetter.uppercased() + dropFirst()
    }
}

//
//  ValidationRules.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 6/11/2568 BE.
//

import Foundation
import RegexBuilder

struct ValidationRules {
    @available(iOS 16.0, *)
    static let emailRegex = Regex {
        /^/
        OneOrMore {
            CharacterClass(
                .anyOf("._%+-"),
                ("a"..."z"),
                ("A"..."Z"),
                ("0"..."9")
            )
        }
        "@"
        OneOrMore {
            CharacterClass(
                .anyOf(".-"),
                ("a"..."z"),
                ("A"..."Z"),
                ("0"..."9")
            )
        }
        "."
        Repeat(2...) {
            CharacterClass(
                ("a"..."z"),
                ("A"..."Z")
            )
        }
        /$/
    }
}

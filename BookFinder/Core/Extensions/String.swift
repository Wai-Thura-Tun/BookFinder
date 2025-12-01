//
//  String.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 6/11/2568 BE.
//

import Foundation
import RegexBuilder

extension String {
    var isEmail: Bool {
        if #available(iOS 16, *) {
            return (try? ValidationRules.emailRegex.wholeMatch(in: self)) != nil
        } else {
            // Use NSPredicate with a properly escaped regex for older iOS versions
            let emailRegexString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegexString)
            return predicate.evaluate(with: self)
        }
    }
    
}

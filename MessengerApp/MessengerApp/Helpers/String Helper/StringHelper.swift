//
//  StringHelper.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit

extension String {
    
    // MARK: - String Operations
    
    public func substringAfter(_ char: Character) -> String {
        guard self.contains(char) else { return self }
        let beginOfSentence = self.firstIndex(of: char)!
        let substring = self[beginOfSentence...]
        return String(substring)
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    // MARK: - String Validations
    
    public func isValid() -> Bool {
        let selfWithWhitespaces = replacingOccurrences(of: " ", with: "")
        return selfWithWhitespaces.count > 0
    }
    
    public func isFullNameValid() -> Bool {
        let fullNameRegex = "\\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+"
        let fullNameTest = NSPredicate(format: "SELF MATCHES %@", fullNameRegex)
        return fullNameTest.evaluate(with: self)
    }
    
    public func isEmailValid() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
}

//
//  ErrorHandling.swift
//  functional-thinking
//
//  Created by jinchu darwin on 16/3/3.
//  Copyright © 2016年 FullStackOrient. All rights reserved.
//

import Foundation

protocol JSONParsable {
    static func parse(json: [String: AnyObject]) throws -> Self
}

enum ParseError: ErrorType {
    case AttributeMissed(message: String)
}

struct MyPerson: JSONParsable {
    let firstName: String
    let lastName: String
    
    static func parse(json: [String: AnyObject]) throws -> MyPerson {
        guard let firstName = json["first-name"] as? String else {
//            throw NSError(domain: "Attribute missed", code: 1, userInfo: nil)
            throw ParseError.AttributeMissed(message: "first-name missed")
        }
        guard let lastName = json["last-name"] as? String else {
//            throw NSError(domain: "Attribute missed", code: 2, userInfo: nil)
            throw ParseError.AttributeMissed(message: "last-name missed")
        }
        return MyPerson(firstName: firstName, lastName: lastName)
    }
}

enum StringValidationError: ErrorType {
    case MustStartWith(set: NSCharacterSet, description: String)
}

protocol StringValidationRule {
    func validate(string: String) throws -> Bool
    var errorType: StringValidationError { get }
}

protocol StringValidator {
    var validationRules: [StringValidationRule] { get }
    func validate(string: String) -> (valid: Bool, errors: [StringValidationError])
}

extension StringValidator {
    func validate(string: String) -> (valid: Bool, errors: [StringValidationError]) {
        var errors = [StringValidationError]()
        for rule in validationRules {
            do {
                try rule.validate(string)
            } catch let error as StringValidationError {
                errors.append(error)
            } catch let error {
                fatalError("Unexpected error type: \(error)")
            }
        }
        return (valid: errors.isEmpty, errors)
    }
}

// 扩展String
extension String {
    public func startsWithCharacterFromSet(set: NSCharacterSet) -> Bool {
        guard !isEmpty else {
            return false
        }
        return rangeOfCharacterFromSet(set, options: [], range: startIndex..<startIndex.successor()) != nil
    }
    
    public func endsWithCharacterFromSet(set: NSCharacterSet) -> Bool {
        guard !isEmpty else {
            return false
        }
        
        return rangeOfCharacterFromSet(set, options: [], range: endIndex.predecessor()..<endIndex) != nil
    }
}

struct StartWithCharStringValidationRule: StringValidationRule {
    let charset: NSCharacterSet
    let description: String
    var errorType: StringValidationError {
        return .MustStartWith(set: charset, description: description)
    }
    
    func validate(string: String) throws -> Bool {
        if string.startsWithCharacterFromSet(charset) {
            return true
        }
        else {
            throw self.errorType
        }
    }
}

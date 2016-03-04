//
//  LazyComputation.swift
//  functional-thinking
//
//  Created by jinchu darwin on 16/2/23.
//  Copyright © 2016年 FullStackOrient. All rights reserved.
//

import Foundation

enum LogLevel: Int, CustomStringConvertible{
    case Debug = 1
    case Warning
    case Error
    case Factor
    var description: String{
        switch self {
        case .Debug:
            return "[DBG]"
        case .Error:
            return "[ERR]"
        default:
            return "[UNW]"
        }
    }
}

let CurrentLevel = LogLevel.Warning

func logMessage(logLavel: LogLevel, @autoclosure message:()->String) {
    if logLavel.rawValue > CurrentLevel.rawValue {
        print("\(logLavel):\(message())")
    }
}

func complexLogMessage() -> String {
    print("Doing the calculation")
    return String.init(format:"This is a %@", "complex log message");
}


public func isPalindrome(s: String) -> Bool{
    let sl = s.lowercaseString
    print("Checking \(sl)")
    return sl == String(sl.characters.reverse())
}

public func findFirstPalindrome(s: String) -> String? {
//    split(s.characters) { $0 == " " }
//    let sp = s.componentsSeparatedByString(" ");
//        print("Seperating: \(c)")
//        return c == " "
//    }
    let sp = s.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    let palindromes = sp.lazy.filter{ isPalindrome($0) }
    print("\(palindromes)");
    for p in palindromes {
        return p;
    }
    return nil;
}
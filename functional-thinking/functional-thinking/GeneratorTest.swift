//
//  GeneratorTest.swift
//  functional-thinking
//
//  Created by jinchu darwin on 16/2/23.
//  Copyright © 2016年 FullStackOrient. All rights reserved.
//

import Foundation

class CountdownGenerator: GeneratorType {
    typealias Element = Int
    var element: Element
    
    init<T>(array: [T]) {
        self.element = array.count - 1
    }
    
    func next() -> Element? {
        return self.element < 0 ? nil : element--
    } 
}

struct ReverseSequence<T>: SequenceType {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    typealias Generator = CountdownGenerator
    func generate() -> Generator {
        return CountdownGenerator(array: array)
    }
}

class PowerGenerator: GeneratorType {
    typealias Element = NSDecimalNumber
    
    var power: NSDecimalNumber = NSDecimalNumber(int: 1)
    let two = NSDecimalNumber(int: 2)
    
    func next() -> Element? {
        power = power.decimalNumberByMultiplyingBy(two)
        return power
    } 
}

class FileLinesGenerator: GeneratorType {
    typealias Element = String
    
    var lines: [String]
    
    init(filename: String) {
        if let contents = try? String(contentsOfFile: filename, encoding: NSUTF8StringEncoding) {
            let newLine = NSCharacterSet.newlineCharacterSet()
            lines = contents.componentsSeparatedByCharactersInSet(newLine)
        }
        else {
            lines = []
        }
    }
    
    
    func next() -> Element? {
        if let nextLine = lines.first {
            lines.removeAtIndex(0)
            return nextLine
        } else {
            return nil
        }
    }
}


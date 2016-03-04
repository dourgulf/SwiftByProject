//: Playground - noun: a place where people can play

import UIKit

//
//  like-other-language.swift
//  MakeSwiftLooksLikeOtherLanguage
//
//  Created by Darwin Rie on 16/2/19.
//  Copyright © 2016年 Yinhan Games. All rights reserved.
//

import Foundation
extension Int {
    public func upto(to: Int, action: (Int)->Void) {
        for i in self...to {
            action(i)
        }
    }
    public func upto(to: Int, action: ()->Void) {
        for _ in self...to {
            action()
        }
    }
    public func downto(to: Int, action: (Int)->Void) {
        for i in to...self {
            action(i)
        }
    }
    public func downto(to: Int, action: ()->Void) {
        for _ in to...self {
            action()
        }
    }
    
    public func times(action: (Int)->Void) {
        for i in 0..<self {
            action(i)
        }
    }
    public func times(action: ()->Void) {
        for _ in 0..<self {
            action()
        }
    }
}

extension Range {
    public func each(action: (Range.Generator.Element) -> Void) {
        for i in self {
            action(i)
        }
    }
}


0.upto(10) {
    print("\($0)")
}

10.downto(5) {
    index in print("\(index)")
}

10.times{
    print("do it")
}

let arr = [1,3,5,7,9]
(1...9, 2).each() {
    i in print("index is \(i)")
}

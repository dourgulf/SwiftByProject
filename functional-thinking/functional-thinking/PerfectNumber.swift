//
//  PerfectNumber.swift
//  functional-thinking
//
//  Created by jinchu darwin on 16/2/23.
//  Copyright © 2016年 FullStackOrient. All rights reserved.
//

import Foundation

public enum ClassifierType {
    case Perfect
    case Abundant(Int)
    case Deficient(Int)
}

func memoize<T:Hashable, U>(fn : T -> U) -> T -> U {
    var cache = [T:U]()
    return {
        (val : T) -> U in
        if cache.indexForKey(val) == nil {
            cache[val] = fn(val)
        }
        return cache[val]!
    }
}

var factorsOf: (Int) -> [Int] = memoize { number in
    print("1 calculating")
    return Range(1...number).filter { potential in
        return number % potential == 0
    }
}

public func factorsOf(number: Int) -> [Int] {
    print("2 calculating")
    return Range(1...number).filter { potential in
        return number % potential == 0
    }
}

public func aliquotSum(number: Int) -> Int{
    return factorsOf(number).reduce(0, combine: +) - number
}

public func isPerfect(number: Int) -> Bool {
    return aliquotSum(number) == number
}

public func isAbundant(number: Int) -> Bool {
    return aliquotSum(number) > number
}

public func isDeficient(number: Int) -> Bool {
    return aliquotSum(number) < number
}
public func classify(number: Int) -> ClassifierType {
    let sum = aliquotSum(number)
    if sum == number {
        return .Perfect
    }
    else if sum > number
    {
        return .Abundant(sum)
    }
    else {
        return .Deficient(sum)
    }
}

func carryfun(a: Int)(_ b: Int)(_ c: Int) ->Int {
    return a+b+c;
}


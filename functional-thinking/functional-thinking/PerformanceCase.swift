//
//  PerformanceCase.swift
//  functional-thinking
//
//  Created by jinchu darwin on 16/2/24.
//  Copyright © 2016年 FullStackOrient. All rights reserved.
//

import Foundation

struct BigData {
    var a = 10
    let b = [1,2,3,4,5,6,7,8,9,10]
    let c = "Stringgggggggggggggg"
    init(a: Int) {
        self.a = a
        print("init:\(a)")
    }
}

func address<T: Any>(o: T) -> String {
    return String.init(format: "%018p", unsafeBitCast(o, Int.self))
}

class ReduceContainer {
    var indata: [BigData]
    var outdata: [BigData]
    init(arr: [BigData]) {
        indata = arr
        outdata = []
    }
    func map(elem: BigData){
        outdata.append(elem)
    }
}

func ReduceForMap(arr: [BigData], action: (BigData)->BigData) -> [BigData] {
    let initVal = ReduceContainer(arr: arr)
    print("\(unsafeAddressOf(initVal))")
    return arr.reduce(initVal) { (a: ReduceContainer, elem: BigData) -> ReduceContainer in
        print("\(unsafeAddressOf(a))")
        a.map(elem)
        return a
    }.outdata
}
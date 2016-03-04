//
//  main.swift
//  functional-thinking
//
//  Created by jinchu darwin on 16/2/22.
//  Copyright © 2016年 FullStackOrient. All rights reserved.
//

import Foundation

//let s = "The quick brown fox jumped over anna the dog"
//let p = findFirstPalindrome(s)
//print("\(p)")
//
//let arr = ["a", "b", "c", "d"]
//let rarr = ReverseSequence(array: arr)
//for a in rarr {
//    print("\(a)")
//}

//var arr: [BigData] = []
//for i in 0..<10 {
//    arr.append(BigData(a: i))
//}

//let r = arr.reduce([]) { (var a: [Int], elem: Int) -> [Int] in
//    a.append(elem * 2)
//    return a
//}

//let result = ReduceForMap(arr) { (var elem: BigData) -> BigData in
//    elem.a = elem.a * 2
//    return elem
//}
//
//for r in result {
//    print("\(r.a)")
//}
//
//class Person {
//    let name: String
//    lazy var printName: ()->() = {[weak self] in
//        if let sself = self {
//            print("The name is \(sself.name)")
//        }
//    }
//    
//    init(personName: String) {
//        name = personName
//    }
//    
//    deinit {
//        print("Person deinit \(self.name)")
//    }
//}

//var xiaoMing: Person? = Person(personName: "XiaoMing")
//xiaoMing!.printName()
//xiaoMing = nil

//for i in 0..<10.advancedBy where(i>2) {
//    print("\(i)")
//}

enum AuthorStatus {
    case Late(daysLate: Int)
    case MyLate(Int)
    case OnTime
}

public struct Author {
    let name: String
    let status: AuthorStatus
    init(name: String, status: AuthorStatus) {
        self.name = name
        self.status = status
    }
}

let authors = [
    Author(name: "Chris Wagner", status: .Late(daysLate: 5)),
    Author(name: "Charlie Fulton", status: .Late(daysLate: 1)),
    Author(name: "Evan Dekhayser", status: .OnTime)
]

let authorStatuses = authors.map { $0.status }

var totalDaysLate = 0
for case .Late(let daysLate) in authorStatuses {
    totalDaysLate += daysLate
}

print(totalDaysLate)

for author in authors {
    guard #available(iOS 10.0, ) else { break }
    if case .Late(let daysLate) = author.status where daysLate > 2 {

        print("Ray slaps \(author.name) around a bit " +
        "with a large trout.\n")
    }
}




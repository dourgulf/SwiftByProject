//
//  Observable.swift
//  TaxCalculator
//
//  Created by DarwenRie on 16/3/7.
//  Copyright © 2016年 DarwenRie. All rights reserved.
//

import Foundation

public class ObservableType<T> {
    public typealias WillSetSubscriberType = (newValue: T) -> Void
    public typealias DidSetSubscriberType = (oldValue: T, newValue: T) -> Void
    
    private var willSetWatcher: [WillSetSubscriberType] = []
    private var didSetWatcher: [DidSetSubscriberType] = []
    
    private var rawValue: T {
        willSet {
            willSetWatcher.forEach{ $0(newValue: newValue) }
        }
        didSet {
            didSetWatcher.forEach { $0(oldValue: oldValue, newValue: self.rawValue) }
        }
    }
    
    init(_ v: T) {
        self.rawValue = v
    }
    
    deinit {
        #if DEBUG
            print("ObservableType deinit:\(rawValue)")
        #endif
    }
    
    // TODO: handle duplicated subscriber
    public func subscribeWillSet(watcher: (newValue: T) -> Void) {
        self.willSetWatcher.append(watcher)
    }
    public func subscribeDidSet(watcher: DidSetSubscriberType) {
        self.didSetWatcher.append(watcher)
    }
    
    // Oooooops: deprecated! unhappy!!
    func __conversion() -> T {
        return rawValue
    }
}

// observable <~ value
infix operator <-- { }
// access raw value
postfix operator & { }

/**
 Assign value to observable object
 (Swift can't overwrite the operator= so ....)
 
 - parameter left:  <#left description#>
 - parameter right: <#right description#>
 */
public func <-- <T>(left: ObservableType<T>, right: T) {
    left.rawValue = right
}

/**
 Return the raw value of observing object
 (Swift not support implit type conversion, so ....)
 
 - parameter left: observable object
 
 - returns: raw value
 */
public postfix func & <T>(left: ObservableType<T>) -> T {
    return left.rawValue
}

// TODO: maybe we need to implement all operator? 


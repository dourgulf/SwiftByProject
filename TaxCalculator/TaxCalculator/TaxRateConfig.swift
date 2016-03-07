//
//  TaxRateConfig.swift
//  TaxCalculator
//
//  Created by DarwinRie on 16/3/7.
//  Copyright © 2016年 https://dawenhing.top. All rights reserved.
//

import Foundation

class TaxRateConfig {
    static private let SavedIncomeKey = "SavedIncomeKey"
    // static always lazy
    static var SavedIncome: Double = {
        let income = NSUserDefaults.standardUserDefaults().objectForKey(SavedIncomeKey) as? Double ?? 0.0
        print("Getting SavedIncome(\(income))")
        return income
    }()
    
    static var income: ObservableType<Double> = ObservableType(0.0)
    static func saveIncome(value: Double) {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: SavedIncomeKey)
        #if DEBUG
            NSUserDefaults.standardUserDefaults().synchronize()
        #endif
    }
    
    static private let SavedSelfKey = "SavedSelfKey"
    static let DefaultSelfTaxRate = ["养老": 8, "医疗": 2, "失业": 0.5,  "工伤": 0, "生育": 0, "公积金": 3]
    
    static private let SavedCompanyKey = "SavedCompanyKey"
    static let DefaultCompanyTaxRate = ["养老": 14, "医疗": 8, "失业": 1.2,  "工伤": 5, "生育": 0.85, "公积金": 2]
    
    static var SavedSelfTaxRate: AnyObject? = {
        print("Getting SavedSelfTaxRate")
        return NSUserDefaults.standardUserDefaults().objectForKey(SavedSelfKey)
    }()
    
    static var SavedCompanyTaxRate: AnyObject? = {
        print("Getting SavedCompanyTaxRate")
        return NSUserDefaults.standardUserDefaults().objectForKey(SavedCompanyKey)
    }()

    class func SelfRateForType(name: String) -> Double {
        if let savedRate = self.SavedSelfTaxRate as? [String: Double] {
            print("\(savedRate)")
            // if it has saved config, but not contain our key, use default.
            return savedRate[name] ?? (DefaultSelfTaxRate[name] ?? 0.0)
        }
        return DefaultSelfTaxRate[name] ?? 0.0
    }
    
    class func SaveSelfRateForType(name: String, rate: Double) {
        var savedRate = self.SavedSelfTaxRate as? [String: Double]
        if savedRate == nil {
            savedRate = [String: Double]()
        }
        savedRate![name] = rate
        NSUserDefaults.standardUserDefaults().setObject(savedRate, forKey: SavedSelfKey)
        #if DEBUG
            NSUserDefaults.standardUserDefaults().synchronize()
        #endif
    }
    
    class func CompanyRateForType(name: String) -> Double {
        if let savedRate = self.SavedCompanyTaxRate as? [String: Double] {
            print("\(savedRate)")
            // if it has saved config, but not contain our key, use default.
            return savedRate[name] ?? (DefaultSelfTaxRate[name] ?? 0.0)
        }
        return DefaultCompanyTaxRate[name] ?? 0.0
    }
    
    class func SaveCompanyRateForType(name: String, rate: Double) {
        var savedRate = self.SavedCompanyTaxRate as? [String: Double]
        if savedRate == nil {
            savedRate = [String: Double]()
        }
        savedRate![name] = rate
        NSUserDefaults.standardUserDefaults().setObject(savedRate, forKey: SavedCompanyKey)
        #if DEBUG
            NSUserDefaults.standardUserDefaults().synchronize()
        #endif
    }
}

//
//  TaxRateConfig.swift
//  TaxCalculator
//
//  Created by DarwenRie on 16/3/7.
//  Copyright © 2016年 DarwenRie. All rights reserved.
//

import Foundation

// 税率配置
class TaxRateConfigure {
    static private let SavedIncomeKey = "SavedIncomeKey"
    // static always lazy
    static var SavedIncome: Double = {
        let income = NSUserDefaults.standardUserDefaults().objectForKey(SavedIncomeKey) as? Double ?? 0.0
        print("Getting SavedIncome(\(income))")
        return income
    }()
    
    static var income: ObservableType<Double> = ObservableType(0.0)
    static func SaveIncome(value: Double) {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: SavedIncomeKey)
        #if DEBUG
            NSUserDefaults.standardUserDefaults().synchronize()
        #endif
    }
    
    static var SavedPersonalTaxRate: AnyObject? = {
        print("Getting SavedSelfTaxRate")
        return NSUserDefaults.standardUserDefaults().objectForKey(SavedPersonalKey)
    }()
    
    static var SavedCompanyTaxRate: AnyObject? = {
        print("Getting SavedCompanyTaxRate")
        return NSUserDefaults.standardUserDefaults().objectForKey(SavedCompanyKey)
    }()
    
    static private let SavedPersonalKey = "SavedPersonalKey"
    static let DefaultPersonalTaxRate: [TaxRateType: Double] =
    [.Endowment: 8, .Medical: 2, .Unemployment: 0.5,  .Injury: 0, .Bear: 0, .HousingReserve: 20]
    
    static private let SavedCompanyKey = "SavedCompanyKey"
    static let DefaultCompanyTaxRate: [TaxRateType: Double]  =
    [.Endowment: 14, .Medical: 8, .Unemployment: 1.2,  .Injury: 5, .Bear: 0.85, .HousingReserve: 20]
    
    class func PersonalRate(type: TaxRateType) -> Double {
        if let savedRate = self.SavedPersonalTaxRate as? [TaxRateType: Double] {
            print("\(savedRate)")
            // if it has saved config, but not contain our key, use default.
            return savedRate[type] ?? (DefaultPersonalTaxRate[type] ?? 0.0)
        }
        return DefaultPersonalTaxRate[type] ?? 0.0
    }
    
    class func CompanyRateForType(type: TaxRateType) -> Double {
        if let savedRate = self.SavedCompanyTaxRate as? [TaxRateType: Double] {
            print("\(savedRate)")
            // if it has saved config, but not contain our key, use default.
            return savedRate[type] ?? (DefaultCompanyTaxRate[type] ?? 0.0)
        }
        return DefaultCompanyTaxRate[type] ?? 0.0
    }
    
    static let LadderRate:[Double] = [0.03, 0.1, 0.2, 0.25, 0.3, 0.35, 0.45]
    static let LadderThreshold:[Double] = [0, 105, 555, 1005, 2755, 5505, 13505]
    static let FirstThreshold:Double = 3500
    
    class func calcTax(pureIncome: Double) -> Double {
        let ladderRate = self.LadderRate.map { $0 * (pureIncome - self.FirstThreshold) }
        var afterTax = [Double]()
        afterTax.reserveCapacity(LadderRate.count)
        for i in 0..<ladderRate.count {
            afterTax.append(ladderRate[i] - self.LadderThreshold[i])
        }
        print("\(afterTax)")
        return afterTax.reduce(0) { (max, val) -> Double in
            if val > max {
                return val
            }
            else {
                return max
            }
        }
    }
    /*
    1、工资个税的计算公式为：
    应纳税额＝（工资薪金所得 －“五险一金”－扣除数）×适用税率－速算扣除数
    
    2、2011年 9月1日起执行7级超额累进税率：扣除数为3500元。
    全月应纳税所得额                   税率         速算扣除数(元)
    全月应纳税额不超过1500元          3%             0
    全月应纳税额超过1500元至4500元   10%          105
    全月应纳税额超过4500元至9000元   20%          555
    全月应纳税额超过9000元至35000元  25%          1005
    全月应纳税额超过35000元至55000元 30%          2755
    全月应纳税额超过55000元至80000元35%          5505
    全月应纳税额超过80000元            45%         13505
    
    个税=ROUND(MAX((A6-3500)*{0.03,0.1,0.2,0.25,0.3,0.35,0.45}-{0,105,555,1005,2755,5505,13505},0),2)
    
    　　A6是工资减去应扣减的五金之后的余额。
    */
}

class TaxRateConfig__ {
    static private let SavedIncomeKey = "SavedIncomeKey"
    // static always lazy
    static var SavedIncome: Double = {
        let income = NSUserDefaults.standardUserDefaults().objectForKey(SavedIncomeKey) as? Double ?? 0.0
        print("Getting SavedIncome(\(income))")
        return income
    }()
    
    static var income: ObservableType<Double> = ObservableType(0.0)
    static func SaveIncome(value: Double) {
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
            return savedRate[name] ?? (DefaultCompanyTaxRate[name] ?? 0.0)
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

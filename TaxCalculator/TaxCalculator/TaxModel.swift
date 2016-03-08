//
//  TaxModel.swift
//  TaxCalculator
//
//  Created by jinchu darwin on 16/3/8.
//  Copyright © 2016年 JcLive. All rights reserved.
//

import Foundation

// 纳税分类
enum TaxCategory {
    case Personal       // 个人缴纳
    case Company        // 公司缴纳
}

// 税费税率类型
enum TaxRateType {
    case Endowment      // "养老"
    case Medical        // "医疗"
    case Unemployment   // "失业"
    case Injury         // "工伤"
    case Bear           // "生育"
    case HousingReserve // "公积金"
    
    var labelText: String {
        switch self {
        case .Endowment: return "养老"
        case .Medical: return "医疗"
        case .Unemployment: return "失业"
        case .Injury: return "工伤"
        case .Bear: return "生育"
        case .HousingReserve: return "公积金"
        }
    }
}

// TODO: maybe change to protocol more better
// 税费税率
class TaxRateItem {
    let income: ObservableType<Double>  // 收入
    let type: TaxRateType               // 税费类型
    var taxRate: Double {               // 税率(百分数)
        return 0.0
    }
    var tax: Int {                   // 税费
        return Int(self.income& * self.taxRate/100.0)
    }
    init(income: ObservableType<Double>, type: TaxRateType){
        self.income = income
        self.type = type
    }
}

// 个人税费税率
class PersonalTaxRateItem: TaxRateItem {
    override var taxRate: Double {
        return TaxRateConfigure.PersonalRate(self.type)
    }
}

// 公司税费税率
class CompanyTaxRateItem: TaxRateItem {
    override var taxRate: Double {
        return TaxRateConfigure.CompanyRateForType(self.type)
    }
}

// 个人所得税模型
class TaxModel {
    let income: ObservableType<Double> = ObservableType(0.0)
    var personalTaxItem = [TaxRateItem]() {
        didSet {
            print("personalTaxItem changed")
        }
    }
    var companyTaxItem = [TaxRateItem]()
    init() {
        personalTaxItem.append(PersonalTaxRateItem(income: self.income, type: .Endowment))
        personalTaxItem.append(PersonalTaxRateItem(income: self.income, type: .Medical))
        personalTaxItem.append(PersonalTaxRateItem(income: self.income, type: .Unemployment))
        personalTaxItem.append(PersonalTaxRateItem(income: self.income, type: .Injury))
        personalTaxItem.append(PersonalTaxRateItem(income: self.income, type: .Bear))
        personalTaxItem.append(PersonalTaxRateItem(income: self.income, type: .HousingReserve))

        companyTaxItem.append(CompanyTaxRateItem(income: self.income, type: .Endowment))
        companyTaxItem.append(CompanyTaxRateItem(income: self.income, type: .Medical))
        companyTaxItem.append(CompanyTaxRateItem(income: self.income, type: .Unemployment))
        companyTaxItem.append(CompanyTaxRateItem(income: self.income, type: .Injury))
        companyTaxItem.append(CompanyTaxRateItem(income: self.income, type: .Bear))
        companyTaxItem.append(CompanyTaxRateItem(income: self.income, type: .HousingReserve))
    }
    
    func getTaxRateItem(type: TaxRateType, category: TaxCategory) -> TaxRateItem {
        switch(category) {
        case .Personal:
            return self.personalTaxItem.filter { $0.type == type } [0]
        case .Company:
            return self.companyTaxItem.filter { $0.type == type } [0]
        }
    }
    
    // 每项都是取整相加, 不是总和取整
    // TODO: 考证这里的取整算法
    var personalTax: Int {
        return self.personalTaxItem.reduce(0) { (sum, item) -> Int in
            return sum + item.tax
        }
    }
    
    var companyTax: Int {
        return self.companyTaxItem.reduce(0) { (sum, item) -> Int in
            return sum + item.tax
        }
    }
}

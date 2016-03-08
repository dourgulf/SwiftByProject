//
//  TaxItemView.swift
//  TaxCalculator
//
//  Created by DarwenRie on 16/3/4.
//  Copyright © 2016年 DarwenRie. All rights reserved.
//

import UIKit

//@IBDesignable
class TaxRateItemView: UIView, UITextFieldDelegate {
    var taxRateItem: TaxRateItem! {
        didSet {
            let formater = NSNumberFormatter()
            formater.numberStyle = .DecimalStyle
            self.percentInput.text = formater.stringFromNumber(self.taxRateItem.taxRate)
            self.updateResultLabel()
            self.taxRateItem.income.subscribeDidSet { (oldValue, newValue) -> Void in
                self.updateResultLabel()
            }
        }
    }

    var percentInput: UITextField!
    var percentLabel: UILabel!
    var resultLabel: UILabel!
    func setupSubviews() {
        let font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        percentInput = UITextField()
        percentInput.font = font
        percentInput.borderStyle = .RoundedRect
        percentInput.delegate = self
        self.addSubview(percentInput)
        percentLabel = UILabel()
        percentLabel.font = font
        percentLabel.text = "%"
        self.addSubview(percentLabel)
        resultLabel = UILabel()
        resultLabel.font = font
        self.addSubview(resultLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    override func layoutSubviews() {
        let size = self.bounds.size
        let centery = size.height/2
        
        let inputWidth = CGFloat(40)
        self.percentInput.frame = CGRect(x: 0, y: 0, width: inputWidth, height: min(size.height, 22));
        self.percentInput.center.y = centery
        
        self.percentLabel.sizeToFit()
        self.percentLabel.frame.origin = CGPoint(x: inputWidth+1, y: 0)
        self.percentLabel.center.y = centery
        
        let resultX = inputWidth + percentLabel.frame.size.width + 4
        let resultWidth = size.width - resultX
        self.resultLabel.frame = CGRect(x: resultX, y: 0, width: resultWidth, height: size.height)
        self.resultLabel.center.y = centery
    }
    
//    var taxRate: Double {
//        let formater = NSNumberFormatter()
//        formater.numberStyle = .DecimalStyle
//        return formater.numberFromString(self.percentInput.text!) as! Double
//    }
//
//    var tax: Int {
//        return Int(self.taxRateItem.income& * self.taxRate / 100.0)
//    }
//
//    var taxRateChanged: ObservableType<Double> = ObservableType(0)
    
    func updateResultLabel() {
        let formater = NSNumberFormatter()
        formater.numberStyle = .DecimalStyle
        self.resultLabel.text = formater.stringFromNumber(self.taxRateItem.tax)
    }
//
    // MARK: text field delegate
    func textFieldDidEndEditing(textField: UITextField) {
        self.updateResultLabel()
//        self.taxRateItem.taxRate = self.taxRate
    }
}
class TaxItemView: UIView {
    var taxModel: TaxModel!
    func setupModel(model: TaxModel, type: TaxRateType) {
        self.taxModel = model
        self.personalRateView.taxRateItem = model.getTaxRateItem(type, category: .Personal)
        self.companyRateView.taxRateItem = model.getTaxRateItem(type, category: .Company)
        self.typeNameLabel.text = type.labelText
    }
    var typeNameLabel: UILabel!
    var personalRateView: TaxRateItemView!
    var companyRateView: TaxRateItemView!
    func setupSubviews() {
        typeNameLabel = UILabel()
        typeNameLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())

        self.addSubview(typeNameLabel)
        self.personalRateView = TaxRateItemView()
//        self.selfRateView.taxRateChanged.subscribeDidSet { (oldValue, newValue) -> Void in
//            TaxRateConfig.SaveSelfRateForType(self.typeName!, rate: self.selfTaxRate)
//        }
        self.addSubview(self.personalRateView)
        
        self.companyRateView = TaxRateItemView()
//        self.companyRateView.taxRateChanged.subscribeDidSet { (oldValue, newValue) -> Void in
//            TaxRateConfig.SaveCompanyRateForType(self.typeName!, rate: self.companyTaxRate)
//        }
        self.addSubview(self.companyRateView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    override func layoutSubviews() {
        // TODO: maybe move this code to other place
        let size = self.bounds
        self.typeNameLabel.frame = CGRect(x: 0, y: 0, width: 60, height: size.height)
        let centery = size.height/2
        self.typeNameLabel.center.y = centery
        let xpos = self.typeNameLabel.bounds.width
        let width = (size.width - xpos) / 2
        self.personalRateView.frame = CGRect(x: xpos, y: 0, width: width, height: size.height)
        self.personalRateView.center.y = centery
        self.companyRateView.frame = CGRect(x: xpos + width, y: 0, width: width, height: size.height)
        self.companyRateView.center.y = centery
    }
    
    func closeKeyboard() {
        self.personalRateView.percentInput.resignFirstResponder()
        self.companyRateView.percentInput.resignFirstResponder()
    }
}

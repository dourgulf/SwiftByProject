//
//  TaxItemView.swift
//  TaxCalculator
//
//  Created by jinchu darwin on 16/3/4.
//  Copyright © 2016年 JcLive. All rights reserved.
//

import UIKit

//@IBDesignable
public class TaxRateItemView: UIView, UITextFieldDelegate {
//    var taxPercent: Double = 0.0 {
//        didSet {
//            let formater = NSNumberFormatter()
//            formater.numberStyle = .DecimalStyle
//            percentInput.text = formater.stringFromNumber(taxPercent)
//            self.updateResultLabel()
//        }
//    }
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    public override func layoutSubviews() {
//        print("\(String(self.dynamicType)) layoutSubviews")
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
    
    // MARK: text field delegate
    public func textFieldDidEndEditing(textField: UITextField) {
        self.updateResultLabel()
    }
    
    func updateResultLabel() {
        let formater = NSNumberFormatter()
        formater.numberStyle = .DecimalStyle
        // 取整!
        let tax = formater.numberFromString(self.percentInput.text!) as! Double
        self.resultLabel.text = formater.stringFromNumber(Int(TaxRateConfig.income& * tax / 100.0))
    }
}

public class TaxItemView: UIView {
    var typeName: String? {
        didSet {
            self.typeNameLabel.text = self.typeName
            let formater = NSNumberFormatter()
            formater.numberStyle = .DecimalStyle
            
            self.selfRateView.percentInput.text = formater.stringFromNumber(TaxRateConfig.selfRateForType(self.typeName!))
            self.companyRateView.percentInput.text = formater.stringFromNumber(TaxRateConfig.companyRateForType(self.typeName!))
        }
    }
    
    var typeNameLabel: UILabel!
    var selfRateView: TaxRateItemView!
    var companyRateView: TaxRateItemView!
    func setupSubviews() {
        typeNameLabel = UILabel()
        typeNameLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())

        self.addSubview(typeNameLabel)
        selfRateView = TaxRateItemView()

        self.addSubview(selfRateView)
        companyRateView = TaxRateItemView()
        self.addSubview(companyRateView)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    public override func layoutSubviews() {
        // TODO: maybe move this code to other place
        let size = self.bounds
        self.typeNameLabel.frame = CGRect(x: 0, y: 0, width: 60, height: size.height)
        let centery = size.height/2
        self.typeNameLabel.center.y = centery
        let xpos = self.typeNameLabel.bounds.width
        let width = (size.width - xpos) / 2
        self.selfRateView.frame = CGRect(x: xpos, y: 0, width: width, height: size.height)
        self.selfRateView.center.y = centery
        self.companyRateView.frame = CGRect(x: xpos + width, y: 0, width: width, height: size.height)
        self.companyRateView.center.y = centery
    }
    
    public func watchIncomeChangedEvent() {
        TaxRateConfig.income.subscribeDidSet { (oldValue, newValue) -> Void in
            print("SavedIncome change, update result")
            self.selfRateView.updateResultLabel()
            self.companyRateView.updateResultLabel()
        }
    }
    
    public func closeKeyboard() {
        self.selfRateView.percentInput.resignFirstResponder()
        self.companyRateView.percentInput.resignFirstResponder()
    }
}

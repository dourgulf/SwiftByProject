//
//  TaxItemView.swift
//  TaxCalculator
//
//  Created by jinchu darwin on 16/3/4.
//  Copyright © 2016年 JcLive. All rights reserved.
//

import UIKit

//@IBDesignable
public class TaxItemView: UIView {
    var income: Double = 10000.0
    var taxPercent: Double = 0.08 {
        didSet {
            resultLabel.text = String(format: "%.0f", arguments:[income*taxPercent])
        }
    }
    
    var percentInput: UITextField!
    var percentLabel: UILabel!
    var resultLabel: UILabel!
    func setupSubviews() {
        percentInput = UITextField()
        self.addSubview(percentInput)
        percentLabel = UILabel()
        percentLabel.text = "%"
        self.addSubview(percentLabel)
        resultLabel = UILabel()
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
        let size = self.bounds.size
        let inputWidth = size.width * 0.35
        percentInput.frame = CGRect(x: 0, y: 0, width: inputWidth, height: size.height);
        percentLabel.sizeToFit()
        percentLabel.frame.origin = CGPoint(x: inputWidth+1, y: 0)
        let resultX = inputWidth + percentLabel.frame.size.width + 4
        let resultWidth = size.width - resultX
        resultLabel.frame = CGRect(x: resultX, y: 0, width: resultWidth, height: size.height)
    }
}

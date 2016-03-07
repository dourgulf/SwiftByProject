//
//  ViewController2.swift
//  TaxCalculator
//
//  Created by jinchu darwin on 16/3/7.
//  Copyright © 2016年 JcLive. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet weak var incomeInput: UITextField!
    
    @IBOutlet weak var endowmentView: TaxItemView!
    @IBOutlet weak var medicalView: TaxItemView!
    @IBOutlet weak var unemploymentView: TaxItemView!
    @IBOutlet weak var injuryView: TaxItemView!
    @IBOutlet weak var bearView: TaxItemView!
    @IBOutlet weak var fundView: TaxItemView!

    var allViews: [TaxItemView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        let tap = UITapGestureRecognizer(target: self, action: "onViewTapped:")
        self.view.addGestureRecognizer(tap)
        
        endowmentView.typeName = "养老"
        medicalView.typeName = "医疗"
        unemploymentView.typeName = "失业"
        injuryView.typeName = "工伤"
        bearView.typeName = "生育"
        fundView.typeName = "公积金"
        
        self.allViews = [endowmentView, medicalView, unemploymentView, injuryView, bearView, fundView]
        self.allViews.forEach { $0.watchIncomeChangedEvent() }
        TaxRateConfig.income <-- TaxRateConfig.SavedIncome
        
        let income = TaxRateConfig.income&
        if income > 0.0 {
            self.incomeInput.text = NSNumberFormatter().stringFromNumber(income)
        }
    }
    func onViewTapped(sender: AnyObject?) {
        self.incomeInput.resignFirstResponder()
        self.allViews.forEach { $0.closeKeyboard() }
    }
    
    @IBAction func doCalc(sender: AnyObject) {
        onViewTapped(sender)
        
        let income = self.incomeInput.text!
        guard !income.isEmpty else {
            return
        }
        let incomeValue = NSNumberFormatter().numberFromString(income) as! Double
        TaxRateConfig.income <-- incomeValue
    }
}

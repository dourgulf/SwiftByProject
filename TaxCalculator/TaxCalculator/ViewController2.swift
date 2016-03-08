//
//  ViewController2.swift
//  TaxCalculator
//
//  Created by DarwenRie on 16/3/7.
//  Copyright © 2016年 DarwenRie. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    let taxModel = TaxModel()
    @IBOutlet weak var incomeInput: UITextField!
    
    @IBOutlet weak var endowmentView: TaxItemView!
    @IBOutlet weak var medicalView: TaxItemView!
    @IBOutlet weak var unemploymentView: TaxItemView!
    @IBOutlet weak var injuryView: TaxItemView!
    @IBOutlet weak var bearView: TaxItemView!
    @IBOutlet weak var fundView: TaxItemView!

    @IBOutlet weak var afterTaxIncomeLabel: UILabel!
    @IBOutlet weak var personalTaxLabel: UILabel!
    @IBOutlet weak var companyTaxLabel: UILabel!
    
    
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
        
        endowmentView.setupModel(self.taxModel, type: .Endowment)
        medicalView.setupModel(self.taxModel, type: .Medical)
        unemploymentView.setupModel(self.taxModel, type: .Unemployment)
        injuryView.setupModel(self.taxModel, type: .Injury)
        bearView.setupModel(self.taxModel, type: .Bear)
        fundView.setupModel(self.taxModel, type: .HousingReserve)
        
        self.allViews = [endowmentView, medicalView, unemploymentView, injuryView, bearView, fundView]
        
        self.taxModel.income.subscribeDidSet { (oldValue, newValue) -> Void in
            TaxRateConfigure.SaveIncome(newValue)
            if newValue > 0.0 {
                let formater = NSNumberFormatter()
                self.incomeInput.text = formater.stringFromNumber(newValue)
            }
            else {
                self.incomeInput.text = ""
            }
            self.personalTaxLabel.text = "个人(\(self.taxModel.personalTax))"
            self.companyTaxLabel.text = "单位(\(self.taxModel.companyTax))"
        }
        self.taxModel.income <-- TaxRateConfigure.SavedIncome
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
        let incomeValue = NSNumberFormatter().numberFromString(income) as? Double ?? 0.0
        self.taxModel.income <-- incomeValue
        TaxRateConfigure.calcTax(incomeValue - Double(self.taxModel.personalTax))
    }
}

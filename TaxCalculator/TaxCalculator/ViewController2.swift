//
//  ViewController2.swift
//  TaxCalculator
//
//  Created by DarwinRie on 16/3/7.
//  Copyright © 2016年 https://dawenhing.top. All rights reserved.
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

    @IBOutlet weak var afterTaxIncomeLabel: UILabel!
    @IBOutlet weak var selfTaxLabel: UILabel!
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
        
        endowmentView.typeName = "养老"
        medicalView.typeName = "医疗"
        unemploymentView.typeName = "失业"
        injuryView.typeName = "工伤"
        bearView.typeName = "生育"
        fundView.typeName = "公积金"
        
        self.allViews = [endowmentView, medicalView, unemploymentView, injuryView, bearView, fundView]
        self.allViews.forEach { $0.watchIncomeChangedEvent() }
        TaxRateConfig.income <-- TaxRateConfig.SavedIncome
        TaxRateConfig.income.subscribeDidSet { (_, newValue) -> Void in
            TaxRateConfig.saveIncome(newValue)
        }
        
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

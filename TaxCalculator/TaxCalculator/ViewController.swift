//
//  ViewController.swift
//  TaxCalculator
//
//  Created by jinchu darwin on 16/3/4.
//  Copyright © 2016年 JcLive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var endowmentSelfView: TaxItemView!
    @IBOutlet weak var endowmentCompanyView: TaxItemView!
    
    @IBOutlet weak var medicalSelfView: TaxItemView!
    @IBOutlet weak var medicalCompanyView: TaxItemView!
    
    @IBOutlet weak var unemploymentSelfView: TaxItemView!
    @IBOutlet weak var unemploymentCompanyView: TaxItemView!
    
    @IBOutlet weak var injurySelfView: TaxItemView!
    @IBOutlet weak var injuryCompanyView: TaxItemView!
    
    @IBOutlet weak var bearSelfView: TaxItemView!
    @IBOutlet weak var bearCompanyView: TaxItemView!
    
    @IBOutlet weak var fundSelfView: TaxItemView!
    @IBOutlet weak var fundCompanyView: TaxItemView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultTaxRate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let defaultSelfTaxRate = ["养老": 0.08, "医疗": 0.02, "失业": 0.005,  "工伤": 0.0, "生育": 0.0, "公积金": 0.3]
    let selfSavedKey = "SelfTaxRate"
    let defaultCompanyTaxRate = ["养老": 0.14, "医疗": 0.08, "失业": 0.012,  "工伤": 0.05, "生育": 0.0085, "公积金": 0.2]
    let companySavedKey = "CompanyTaxRate"
    func setupDefaultTaxRate() {
        let savedSelfTaxRate = (NSUserDefaults.standardUserDefaults().objectForKey(self.selfSavedKey) ?? defaultSelfTaxRate) as! [String : Double]
        let selfViews = [endowmentSelfView, medicalSelfView, unemploymentSelfView, injurySelfView, bearSelfView, fundSelfView]
        for view in selfViews {
            let key: String = view.percentLabel.text!
            view.taxPercent = savedSelfTaxRate[key]!
        }
        
        let companyViews = [endowmentCompanyView, medicalCompanyView, unemploymentCompanyView, injuryCompanyView, bearCompanyView, fundCompanyView]
        let savedCompanyTaxRate = (NSUserDefaults.standardUserDefaults().objectForKey(self.companySavedKey) ?? defaultCompanyTaxRate) as! [String : Double]
        for view in companyViews {
            let key: String = view.percentLabel.text!
            view.taxPercent = savedCompanyTaxRate[key]!
        }
    }
}


//
//  SettingsController.swift
//  TipCalculator
//
//  Created by Youssef Elabd on 10/20/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var defaultSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard

        let integerValue = defaults.integer(forKey: "defaultTip")
        
        defaultSegmentedControl.selectedSegmentIndex = integerValue
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func valueChanged(_ sender: Any) {
        let defualts = UserDefaults.standard
        
        defualts.set(defaultSegmentedControl.selectedSegmentIndex, forKey: "defaultTip")
        
        defualts.synchronize()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

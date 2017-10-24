//
//  ViewController.swift
//  TipCalculator
//
//  Created by Youssef Elabd on 10/10/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipDisplayLabel: UILabel!
    @IBOutlet weak var tipPercentage: UISegmentedControl!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    var nonZero = false
    var isDown = true
    
    let percentages = [0.18,0.2,0.22]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        
        let integerValue = defaults.integer(forKey: "defaultTip")
        
        tipPercentage.selectedSegmentIndex = integerValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTouch(_ sender: Any) {
        if amountTextField.text == "" {
            UIView.animate(withDuration: 0.3) {
                self.amountTextField.center.y -= 100
                
            }
        }
        
    }
    
    @IBAction func editingEnded(_ sender: Any) {
        print("editing ended")
        if let text = amountTextField.text {
            if text == "" {
                UIView.animate(withDuration: 0.3) {
                    self.amountTextField.center.y += 100
                    self.tipPercentage.center.y += 100
                    self.tipPercentage.isHidden = true
                    if !self.isDown{
                        self.tipLabel.frame.origin.y += (self.tipLabel.frame.height)
                       
                        self.tipDisplayLabel.frame.origin.y += (self.tipDisplayLabel.frame.height)
                         self.tipDisplayLabel.isHidden = true
                        self.isDown = true
                    }
                        self.nonZero = false
                }
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                //print("in else")
                self.amountTextField.center.y += 100
                self.tipPercentage.center.y += 100
                self.tipPercentage.isHidden = true
            }
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        if !nonZero {
           nonZero = true
            UIView.animate(withDuration: 0.3) {
                print(self.tipLabel.frame.height)
                self.isDown = false
                self.tipLabel.frame.origin.y -= (self.tipLabel.frame.height)
                self.tipDisplayLabel.isHidden = false
                self.tipDisplayLabel.frame.origin.y -= self.tipDisplayLabel.frame.height
                print("In here")
                if !self.isDown {
                    self.tipPercentage.isHidden = false
                    self.tipPercentage.center.y -= 100
                }
            }
           
        }else{
            
        }
        
        if let total = self.amountTextField.text {
            let billAmount = Double(total) ?? 0
            let tipAmount = billAmount * percentages[tipPercentage.selectedSegmentIndex]
            let finalAmount = billAmount + tipAmount
            
            self.tipLabel.text = "$\(String(finalAmount))"
            self.tipDisplayLabel.text = "Tip is $\(tipAmount)"
        }
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
           
            UIView.animate(withDuration: 0.3) {
                self.tipLabel.frame.origin.y -= (keyboardHeight)
                self.tipDisplayLabel.frame.origin.y -= (keyboardHeight)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
    
            if let text = self.amountTextField.text {
                if text == "" {
                    nonZero = false
                }
            }
            UIView.animate(withDuration: 0.3) {
                self.tipLabel.frame.origin.y += (keyboardHeight)
                self.tipDisplayLabel.frame.origin.y += (keyboardHeight)
            }
            
        }
    }
}


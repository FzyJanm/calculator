//
//  ViewController.swift
//  Calculater
//
//  Created by 范智渊 on 2017/9/20.
//  Copyright © 2017年 fzy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
       
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurreentluInDisplay = display.text!
            display.text = textCurreentluInDisplay + digit
   
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
 
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var  brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperator(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperator(mathematicalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
   
    
}


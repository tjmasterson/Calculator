//
//  ViewController.swift
//  Calculator
//
//  Created by Taylor Masterson on 5/22/15.
//  Copyright (c) 2015 Taylor Masterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            if (digit == ".") && (display.text!.rangeOfString(".") != nil) {
                return
            }
            display.text = display.text! + digit
        } else {
            if (digit == ".") {
                display.text = "0."
            } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
            }
        }
    }
    

    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }

    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"

        }
    }
}


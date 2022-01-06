//
//  ViewController.swift
//  Calculator
//
//  Created by Aaron Butler on 1/5/22.
//

import UIKit

enum Button: Int {
    case clear = 13
    case opposite
    case percent
    case divide
    case multiply
    case subtract
    case add
    case equals
    case sqrt
    case decimal
}

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var previous: Double = 0.0
    var current: Double = 0.0 {
        didSet {
            if floor(current) == current {
                hasDecimal = false
                placesRightOfDecimal = 0
            } else {
                hasDecimal = true
                let dec: Decimal = Decimal(string: String(current)) ?? Decimal(0)
                placesRightOfDecimal = max(-dec.exponent, 0)
            }
            if hasDecimal {
                current *= 1000000000
                current.round()
                current /= 1000000000
            }
            
        }
    }
    
    var currentString: String = "0" {
        didSet {
            if operation == .decimal {
                display.text = String(currentString.dropLast())
            } else {
                if placesRightOfDecimal != 0 {
                    display.text = currentString
                } else {
                    display.text = String(format: "%.0f", current)
                }
            }
        }
    }

    var operation: Button?
    var previousOperation: Button?
    var hasDecimal: Bool = false
    var isNegative: Bool = false
    var placesRightOfDecimal: Int = 0
    var lastPressWasNumber: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func numberPressed(_ sender: UIButton) {
        lastPressWasNumber = true
        
        let digit = sender.tag
        
        if operation == .decimal {
            operation = nil
            current += Double(digit) / 10
            currentString = String(current)
            placesRightOfDecimal = 1
            hasDecimal = true
            return
        } else if operation != nil {
            previousOperation = operation
            operation = nil
            current = 0.0
            currentString = "0"
            hasDecimal = false
            placesRightOfDecimal = 0
        }
        
        if current == 0 && !hasDecimal {
            current = Double(digit)
            currentString = String(current)
        } else if current == 0 && hasDecimal && placesRightOfDecimal == 0 {
            current = Double(digit) / 10
            currentString = String(current)
            placesRightOfDecimal = 1
        } else if current == 0 && hasDecimal && placesRightOfDecimal != 0 {
            placesRightOfDecimal += 1
            current += Double(digit) / pow(Double(10), Double(placesRightOfDecimal))
            currentString = String(current)
        } else if current != 0 && !hasDecimal {
            current *= 10
            current += Double(digit)
            currentString = String(current)
        } else if current != 0 && hasDecimal {
            placesRightOfDecimal += 1
            current += Double(digit) / pow(Double(10), Double(placesRightOfDecimal))
            currentString = String(current)
        }
        
    }
    @IBAction func operationPressed(_ sender: UIButton) {
        lastPressWasNumber = false
        
        if let newOperation = Button.init(rawValue: sender.tag) {
            switch newOperation {
            case .clear:
                operation = nil
                previousOperation = nil
                current = 0.0
                currentString = "0"
                hasDecimal = false
                placesRightOfDecimal = 0
            case .opposite:
                operation = nil
                current = -current
                currentString = String(current)
                break
            case .percent:
                operation = nil
                current /= 100
                hasDecimal = true
                currentString = String(current)
                placesRightOfDecimal = currentString.count - 2
            case .divide:
                if previousOperation == .divide {
                    current = previous / current
                    currentString = String(current)
                } else if previousOperation == .multiply {
                    current = previous * current
                    currentString = String(current)
                } else if previousOperation == .subtract {
                   current = previous - current
                   currentString = String(current)
                } else if previousOperation == .add {
                    current = previous + current
                    currentString = String(current)
                }
                operation = newOperation
                previous = current
            case .multiply:
                if previousOperation == .divide {
                    current = previous / current
                    currentString = String(current)
                } else if previousOperation == .multiply {
                    current = previous * current
                    currentString = String(current)
                }
                else if previousOperation == .subtract {
                   current = previous - current
                   currentString = String(current)
                } else if previousOperation == .add {
                    current = previous + current
                    currentString = String(current)
                }
                operation = newOperation
                previous = current
            case .subtract:
                if previousOperation == .divide {
                    current = previous / current
                    currentString = String(current)
                } else if previousOperation == .multiply {
                    current = previous * current
                    currentString = String(current)
                } else if previousOperation == .subtract {
                   current = previous - current
                   currentString = String(current)
                } else if previousOperation == .add {
                    current = previous + current
                    currentString = String(current)
                }
                operation = newOperation
                previous = current
            case .add:
                if previousOperation == .divide {
                    current = previous / current
                    currentString = String(current)
                } else if previousOperation == .multiply {
                    current = previous * current
                    currentString = String(current)
                } else if previousOperation == .subtract {
                   current = previous - current
                   currentString = String(current)
                } else if previousOperation == .add {
                    current = previous + current
                    currentString = String(current)
                }
                operation = newOperation
                previous = current
            case .equals:
                if previousOperation == .divide {
                    current = previous / current
                    currentString = String(current)
                } else if previousOperation == .multiply {
                    current = previous * current
                    currentString = String(current)
                } else if previousOperation == .subtract {
                   current = previous - current
                   currentString = String(current)
                } else if previousOperation == .add {
                    current = previous + current
                    currentString = String(current)
                }
                operation = nil
                previousOperation = nil
            case .sqrt:
                operation = nil
                current = sqrt(current)
                currentString = String(current)
            case .decimal:
                operation = newOperation
                if !hasDecimal {
                    hasDecimal = true
                    currentString = String(current)
                }
            }
        }
    }

}


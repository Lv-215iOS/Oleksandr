//
//  CalculatorHead.swift
//  CalcLite
//
//  Created by adminaccount on 12/7/16.
//  Copyright © 2016 adminaccount. All rights reserved.
//


import Foundation

enum ConstantValues: String {
    case Pi = "π"
    case Exp = "e"
}

class CalculatorHead: CalcBrainInterface {
    
    var accumulatorValue: Double? = 0.0
    var operationSavedSymbol: BinaryOperation?
    
    func digit(value: Double) {
        accumulatorValue = value
    }
    
    var result: ((Double?, Error?)->())? = nil
    
    func utility(operation: UtilityOperation) {
        if let operationSymbol = operations[operation.rawValue] {
            switch operationSymbol {
            case .Equals:
                executePendingBinaryOperation()
                result?(accumulatorValue, nil)
            default:
                break
            }
        }
    }
    
    func unary(operation: UnaryOperation) {
        if let operationSymbol = operations[operation.rawValue] {
            switch operationSymbol {
            case .UnaryOperation(let function):
                accumulatorValue = function(accumulatorValue!)
                result?(accumulatorValue, nil)
            default:
                break
            }
        }
    }
    
    func binary(operation: BinaryOperation) {
        saveBinaryOperationSymbol(symbol: operation.rawValue)
        if let operationSymbol = operations[operation.rawValue] {
            switch operationSymbol {
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, fistOperand: accumulatorValue!)
            default:
                break
            }
        }
    }
    
    func constants(operation: ConstantValues) {
        if let operationSymbol = operations[operation.rawValue] {
            switch operationSymbol {
            case .Constant(let value):
                accumulatorValue = value
                result?(accumulatorValue, nil)
            default:
                break
            }
        }
    }
    
    func saveBinaryOperationSymbol(symbol: String) {
        switch symbol {
        case "+": operationSavedSymbol = BinaryOperation.Plus
        case "-": operationSavedSymbol = BinaryOperation.Minus
        case "*": operationSavedSymbol = BinaryOperation.Mul
        case "/": operationSavedSymbol = BinaryOperation.Div
        default:
            break
        }
    }
    
    func perform0peration(symbol: String) {
        if BinaryOperation(rawValue: symbol) != nil {
            let possibleBinary = BinaryOperation(rawValue: symbol)
            self.binary(operation: possibleBinary!)
            
        } else if UnaryOperation(rawValue: symbol) != nil {
            let possibleUnary = UnaryOperation(rawValue: symbol)
            self.unary(operation: possibleUnary!)
            
        } else if UtilityOperation(rawValue: symbol) != nil {
            let possibleUtility = UtilityOperation(rawValue: symbol)
            self.utility(operation: possibleUtility!)
            
        } else if ConstantValues(rawValue: symbol) != nil {
            let possibleConstant = ConstantValues(rawValue: symbol)
            self.constants(operation: possibleConstant!)
        }
    }
    
    func clear() {
        accumulatorValue = 0.0
    }
    
    private var operations: Dictionary <String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        
        "+/-" : Operation.UnaryOperation({ -$0}),
        "%" : Operation.UnaryOperation({$0 / 100}),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation({cos($0 * M_PI / 180)}),
        "sin": Operation.UnaryOperation({sin($0 * M_PI / 180)}),
        "tg" : Operation.UnaryOperation({tan($0 * M_PI / 180)}),
        "ctg": Operation.UnaryOperation({1 / tan($0 * M_PI / 180)}),
        "log": Operation.UnaryOperation(log2),
        
        "*": Operation.BinaryOperation({ $0 * $1 }),
        "/": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "-": Operation.BinaryOperation({ $0 - $1 }),
        " ̂": Operation.BinaryOperation({pow($0, $1)}),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulatorValue = pending!.binaryFunction(pending!.fistOperand, accumulatorValue!)
            pending = nil
            
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var fistOperand: Double
    }
}

//
//  CalculatorHead.swift
//  CalcLite
//
//  Created by adminaccount on 12/7/16.
//  Copyright © 2016 adminaccount. All rights reserved.
//

import Foundation

enum binaryOperation: String {
    case Plus = "+"
    case Minus = "−"
    case Mul = "×"
    case Div = "÷"
}

enum utilityOperation: String {
    case Dot = "."
    case Equal = "="
}

enum unaryOperation: String {
    case Cos = "cos"
    case Sqrt = "Sqrt"
}

protocol CalcBrainInterface {
    func digit(value: Double)
    func binary(operation: binaryOperation)
    func unary(operation: unaryOperation)
    var result: ((Double?, Error?) -> ())? {get set}
    //var result: Double {get}
}

class CalculatorHead: CalcBrainInterface
{

    //private var accumulator = 0.0
    //static let objCalcHead = CalculatorHead()
    
    
    var operandOne: Double?
    var operandTwo: Double?
    var value: Double?
    
    func digit(value: Double) {
        if operandOne == nil {
            operandOne = value
        } else if operandTwo == nil {
            operandTwo = value
        }
    }
    @discardableResult
    func binary(operation: binaryOperation) {
        switch operation {
        /*case .Plus: Operation.BinaryOperation({$0 * $1})
        case .Minus: Operation.BinaryOperation({$0 - $1})
        case .Div: Operation.BinaryOperation({$0 / $1})
        case .Mul: Operation.BinaryOperation({$0 * $1})
        */
        case .Plus:
            value = (operandOne ?? 0.0) + (operandTwo ?? 0.0)
        case .Minus:
            value = (operandOne ?? 0.0) - (operandTwo ?? 0.0)
        case .Mul:
            value = (operandOne ?? 0.0) *  (operandTwo ?? 0.0)
        case .Div:
            value = (operandOne ?? 0.0) /  (operandTwo ?? 0.0)
        }
    }
    @discardableResult
    func unary(operation: unaryOperation)  {
        switch operation {
        /*case .Cos: Operation.Constant(M_PI)
        case .Sqrt: Operation.Constant(M_E)*/
        case .Sqrt:
            value = (sqrt (operandOne ?? 0.0 ))
        case .Cos:
            value = (cos(operandOne ?? 0.0 ))
        }
        
    }
    func utility(operation: utilityOperation) {
        switch operation {
        //case .Dot:
        case .Equal: //Operation.Equals
            result?(value, nil)
        default:
            break
        }
    }
    
    func perform0peration(symbol: String) {
        if binaryOperation(rawValue: symbol) != nil {
            let possibleBinary = binaryOperation(rawValue: symbol)
            binary(operation: possibleBinary!)
            
        } else if unaryOperation(rawValue: symbol) != nil {
            let possibleUnary = unaryOperation(rawValue: symbol)
            unary(operation: possibleUnary!)
            
        } else if utilityOperation(rawValue: symbol) != nil {
            let possibleUtility = utilityOperation(rawValue: symbol)
            utility(operation: possibleUtility!)
        }
        
    }

    var result: ((Double?, Error?)->())? = nil
    /*
    func set0perand(operand: Double) {
        accumulator = operand
    }
    private var operations: Dictionary <String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "±" : Operation.UnaryOperation({ -$0}),
        "Sqrt" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }*/
    
    /*func perform0peration(symbol: String) {
        if let operation = operations[symbol]{
            switch operation{
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, fistOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }*/
    
        /*
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.fistOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    
    private struct PendingBinaryOperationInfo{
        var binaryFunction: (Double, Double) -> Double
        var fistOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }*/
    
}









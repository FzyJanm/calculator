//
//  operationBrain.swift
//  Calculater
//
//  Created by 范智渊 on 2017/9/21.
//  Copyright © 2017年 fzy. All rights reserved.
//

import Foundation

func changeSign (oprand: Double) -> Double{
    return -oprand
}
func multiply (op1: Double,op2: Double) -> Double {
    return op1 * op2
}
func divide (op1: Double,op2: Double) -> Double {
    return op1 / op2
}
func plus (op1: Double,op2: Double) -> Double {
    return op1 + op2
}
func subtract (op1: Double,op2: Double) -> Double {
    return op1 - op2
}
struct CalculatorBrain {
    
    private var abc: Double
    private var accumulator: Double?
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) ->Double)
        case binaryoperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos":Operation.unaryOperation(cos),
        "±" :Operation.unaryOperation(changeSign),
        "+" :Operation.binaryoperation(plus),
        "-" :Operation.binaryoperation(subtract),
        //        "×" :Operation.binaryoperation({(op1: Double,op2: Double) in return op1 * op2}),closer 简化一
        //        "×" :Operation.binaryoperation({(op1,op2) in  op1 * op2}),简化二
        "×" :Operation.binaryoperation({$0 * $1}), //简化三
        
        "÷" :Operation.binaryoperation(divide),
        "=" :Operation.equals
        
    ]
    mutating func performOperator(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let funciton):
                if accumulator != nil {
                    accumulator = funciton(accumulator!)
                }
            case .binaryoperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperation: accumulator!)
                }
                
            case .equals:
                performPendingBinaryOperation()
                    
                
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    private var pendingBinaryOperation: PendingBinaryOperation?
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperation: Double
        
        func perform(with secondOperation: Double) -> CDouble {
            return function(firstOperation,secondOperation)
        }
        
    }
    
    mutating func setOperator (_ operand: Double) {
        accumulator = operand
    }
    var result: Double? {
        get {
            return accumulator
        }
    }
    
    
}



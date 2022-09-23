//
//  Calculator.swift
//  Kadai1-MVVM
//
//  Created by 近藤米功 on 2022/09/23.
//

import Foundation

class Calculator {
    private var number1 = 0
    private var number2 = 0
    private var number3 = 0
    var sum = 0

    func addition(number1: Int,number2: Int,number3: Int) {
        sum = number1 + number2 + number3
    }
}

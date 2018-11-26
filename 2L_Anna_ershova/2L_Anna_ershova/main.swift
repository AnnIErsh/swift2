//
//  main.swift
//  2l_Anna_Ershova
//
//  Created by Anna Ershova on 24/11/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import Foundation
func devision () {// разделение
    print("==================================")
}
func evenNumber(_ number: Int) -> Bool { //функция, определяющая четное число или нет
    return number % 2 == 0 && number != 0
}
print("Enter your number: ")
var number = Int(readLine()!)!
print("Проверка на четность", evenNumber(number))
devision()
func isDevide (_ number: Int) -> Bool{ //функция, которая определяет, делится ли число без остатка на 3
    return number % 3 == 0
}
print("Проверка деления на 3: ", isDevide(number))
devision()

var array: [Int] = []//Создать возрастающий массив из 100 чисел.
for i in 0...99 {
    array.append(i)
}
var newArray = array
print("Your array is: ", newArray)
for value in newArray { //Удалить из этого массива все четные числа и все числа, которые не делятся на 3
    if evenNumber(value) || !isDevide(value) {
        newArray.remove(at: newArray.index(of: value)!)
    }
}
devision()
print("Your array after deleted numbers is: ", newArray)

func numberFibonacci (_ n: Int) -> Float {//* Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов. Fn=Fn-1 + Fn-2
    var a: Float = 0
    var b: Float = 1
    
    for _ in 0..<n {
        a += b
        b = a - b
    }
    return a
}
var arrayFib: [Float] = []
for i in 1...100 {
    arrayFib.append(Float(numberFibonacci(i)))
}
print("100 Fibonacci numbers are: ", arrayFib)
devision()

//* Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
////e. Повторять шаги c и d, пока возможно.
//var n: Int = 120
//var arrayErat = [Int](2...n)
//var p: Int = 2
//var value: Int = 2
//for value in stride(from: 2*p, to: n, by: p) {
//        arrayErat.remove(at: arrayErat.index(of: value)!)
//    }
//n = arrayErat.count
//print(p)
//print(arrayErat)
//print(n)

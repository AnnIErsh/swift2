//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу
import UIKit
protocol Tan{ // определение тангенса
    func tan() -> Double
}
class Points: Tan {
    var x: Double
    var y: Double
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    func tan() -> Double { // коэффициент k в классе Points (тангенс угла наклона прямой проходящей через начало координат)
        return y / x
    }
}
extension Points : CustomStringConvertible {
    var description: String {
        return "[x: \(self.x), y: \(self.y)]"
    }
}
class Line: Tan {
    var point1: Points
    var point2: Points

    init(x1: Double, x2: Double, y1: Double, y2: Double) {
        self.point1 = Points(x: x1, y: y1)
        self.point2 = Points(x: x2, y: y2)
    }
    func lengthLine () -> Double {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.x, 2))
    }
    func tan() -> Double { // коэффициент k в классе Line (тангенс угла наклона прямой)
        return point2.y - point1.y / point2.x - point1.x
    }
}
extension Line : CustomStringConvertible{
    var description: String {
        return " [ Length = \(String(format:"%.2f",lengthLine())) , k = Tan : \(String(format:"%.2f",tan()))] " // длина отрезка и тангенс угла наклона прямой
    }
}

struct Queue<T: Tan> {
    fileprivate var elements: [T] = []
    
    public var isEmpty: Bool {
        print("empty")
        return elements.count == 0
    }
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        return elements.removeFirst()
    }
    public var firstElement: T? {
        if isEmpty {
            print("нет элементов")
            return nil
        } else {
            print("\(elements.first!) - первый элемент")
            return elements.first
        }
    }
    var sumTan: Double { // для каждой очереди подсчитаем сумму тангенсов угла наклона
        var sum = 0.0
        
        for element in elements {
            sum += element.tan()
        }
        return sum
    }
    subscript(elements: Int ...) -> Double {  // доступ к стеку по индексу
        var sum = 0.0
        for index in elements where index < self.elements.count {
            sum += self.elements[index].tan()
        }
        return sum
    }
    
    
    
    
    func printElements() {
        print(elements)
    }
    
    public func filter(elements: [T], predicate: (T) -> Bool) -> [T] {
        
        var tmpArray = [T]()
        
        for element in elements {
            if predicate(element) {
                tmpArray.append(element)
            }
        }
        
        return tmpArray
    }
    
    

}



var queueLine = Queue<Line>()
var queuePoint = Queue<Points>()

queuePoint.push(Points(x: 2, y: 3))
queuePoint.printElements()
queuePoint.push(Points(x: 4, y: 5))
queuePoint.printElements()
queuePoint.push(Points(x: 6, y: 7))
queuePoint.push(Points(x: 8, y: 9))
queuePoint.printElements()
queuePoint.push(Points(x: 10, y: 11))
queuePoint.printElements()
//queueLine.firstElement
queuePoint.pop()
queuePoint.pop()
queuePoint.push(Points(x: 3, y: 9))
queuePoint.printElements()
print("общая сумма коэффициентов k класса Points: \(queuePoint.sumTan)")

print(queuePoint[1]) // коэффициент k у элемента массива с индексом 1

print(queuePoint[6])

let k1 = queuePoint.filter(elements: queuePoint.elements, predicate: {$0.y == 9}) // фильт элементов у которых координата y = 9)
print("фильт точек у которых координата y = 9 \(k1)")


queueLine.push(Line(x1: 2, x2: 4, y1: -3, y2: 13))
queueLine.printElements()
queueLine.push(Line(x1: 3, x2: 12, y1: -4, y2: 1))
queueLine.printElements()
queueLine.push(Line(x1: 6, x2: 4, y1: -3, y2: 13))
queueLine.printElements()
queueLine.push(Line(x1: -90, x2: 10, y1: 4, y2: 1))
queueLine.printElements()
queueLine.push(Line(x1: 8, x2: 42, y1: -43, y2: 13))
queueLine.push(Line(x1: 44, x2: 42, y1: -2, y2: 10))
queueLine.pop()
queueLine.printElements()
queueLine.pop()
queueLine.printElements()
print("общая сумма коэффициентов k класса прямых Line : \(queueLine.sumTan)") // общая сумма коэффициентов k


let k2 = queueLine.filter(elements: queueLine.elements, predicate: {$0.tan() > 0 && $0.lengthLine() > 10.00}) // фильт элементов у которых k > 0 ))
print("фильт прямых у которых тангенс угла наклона > 0: \(k2)")

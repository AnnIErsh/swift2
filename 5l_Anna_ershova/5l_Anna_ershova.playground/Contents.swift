
//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль
import UIKit
enum State {
    case on, off
}


protocol Car {
    var carName: String {get}
    var year: Int {get}
    var speed: Double {get set}
    var engineState: State {get set}
    func engineOnOff() -> State
}

extension Car {
    
    func windowState(state: State) {
        switch state {
        case .on:
            print("Откры окна")
        case .off:
            print("Закры окна")
        }
    }
    
    func doorState(state: State){
        switch state {
        case .on:
            print("Открыты двери")
        case .off:
            print("Закрыты двери")
        }
    }
}

class SportCar: Car {
    
    var carName: String
    
    var year: Int
    
    var speed: Double // начальная скорость автомобиля
    
    var engineState: State
    
    func engineOnOff() -> State { //выключение двигателя только для sportCar из Car
        print("Двигатель включен")
        return .on
    }
    
    var time: Double//время движения
    var acceleration: Double { // ускрение
        willSet { //наблюдение за ускорением при его изменеии
            switch newValue {
            case 0:
                print("\n\(carName) движется равномерно ")
            case ...0:
                print("\n\(carName) тормозит ")
            default:
                print("\n\(carName) идет на разгон ")
            }
        }
    }
    var velocity: Double { //конечная скрорость, вычисляемая
        get {return speed + acceleration * time }
        set {return acceleration = (newValue - speed) / time}
    }
    
    func displacement() -> Double{ // перемещение
        return acceleration * pow(time, 2) / 2 + velocity * time
    }
    
    init(carName: String, year: Int, speed: Double, engineState: State, time: Double, acceleration: Double) {
        self.carName = carName
        self.year = year
        self.speed = speed
        self.engineState = engineState
        self.time = time
        self.acceleration = acceleration
    }
    func getInfo(){
        print(description)
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Автомобиль \(carName) \(year) года проехал дистанцию \(String(format:"%.2f", displacement())) метров со скоротью \(String(format: "%.2f", velocity)) m/sec за \(time) sec с ускорением \(String(format: "%.2f", acceleration)) m/sec*s^2 , двигаясь с начальной скоростью \(speed) m/sec. Двигатель сейчас: \(engineState)\n"
    }
}



class TruckCar: Car {
    var carName: String
    
    var year: Int
    
    var speed: Double = 70
    
    var engineState: State
    
    func engineOnOff() -> State { //выключение двигателя для только truck из Car
        return .off
    }
    
    enum capasityState: String {
        case full = "цистерна полная", empty = "цистерна пустая"
    }
    var capacity: capasityState
    
    init(carName: String, year: Int, engineState: State, capacity: capasityState) {
        self.carName = carName
        self.year = year
        self.engineState = engineState
        self.capacity = capacity
    }
    func getPrint() {
        print(description)
    }
}

extension TruckCar: CustomStringConvertible {
    var description: String {
        return "Автомобиль \(carName) \(year) года едет со скоротью \(speed) m/sec, \(capacity),  Двигатель сейчас: \(engineState)\n"
    }
}

var car1 = SportCar(carName: "Lambo", year: 2019, speed: 11, engineState: .off, time: 3, acceleration: 5)
var car2 = SportCar(carName: "Porsche", year: 2011, speed: 44, engineState: .on, time: 60, acceleration: 6)

var truck1 = TruckCar(carName: "The Hulk", year: 1999, engineState: .on, capacity: .empty)
var truck2 = TruckCar(carName: "Colossus", year: 2000, engineState: .on, capacity: .full)


car1.engineOnOff()
car1.doorState(state: .off)
car1.getInfo()
car1.speed = 23.01
car1.acceleration = 7.7
car1.getInfo()
car1.speed = 12
car1.getInfo()
car1.velocity = 9
car1.getInfo()

car2.windowState(state: .on)
car2.getInfo()
car2.speed = 8.9
car2.acceleration = 9
car2.getInfo()
car2.acceleration = 0
car2.getInfo()
car2.velocity = 12.7
car2.getInfo()

truck1.engineOnOff()
truck1.speed = 80
truck2.capacity = .empty
truck2.speed = 90
truck1.getPrint()
truck2.getPrint()

print(car1,car2,truck1,truck2)


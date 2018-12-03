//import UIKit

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.
class Car {
    let label: String
    let year: Int
    var speed: Int {
        didSet {
            if speed > 500 {
                self.speed = oldValue
                print("\n-------Превышение скорости (>500 km/час) -------\n") //проверка на лимит скорости
            }
        }
    }
    static var carCount = 0
    init (label: String, year: Int, speed: Int) { //общие свойства
        self.label = label
        self.year = year
        self.speed = speed
        Car.carCount += 1
    }
    deinit {
        Car.carCount -= 1
    }
    static func carCountInfo() {
        print("всего \(self.carCount) машин")
    }
    func getInfo() {
        print("============ \n")
        print(" Автомобиль \(label) \(year) года")
    }
    func speedControl (speedLimit: Bool, newSpeedAdd: Int) -> Int{ // контроль скорости
        switch speedLimit {
        case false:
            self.speed -= newSpeedAdd
            print("скорость \(label) снижается до \(speed)")
        case true:
            print("\(label) идет на разгон со скоростью \(speed)")
            self.speed += newSpeedAdd
        }
        return speed
    }
}

class TruckCar: Car { //грузовик
    let capacity: Int
    var load: Int {
        willSet {
            if self.load < 0 {
                print("ERROR! отрицательное значение груза")
                self.load = newValue
            }
        }
        didSet { //проверка после загрузки
            if capacity < load {
                print("------------------\nПерегруз! : ")
                let overload = abs(self.capacity - self.load)
                print("Перегруз \(label) составляет \(overload) \n------------------")
                self.load = oldValue
            }
        }
    }
    enum TrunkState {
        case loadState, unloadState
    }
    var trunkState: TrunkState
    init(label: String, year: Int, capacity: Int, speed: Int, load: Int, trunkState: TrunkState) { //инициализируем св-ва грузовика
        self.capacity = capacity
        self.load = load
        self.trunkState = trunkState
        super.init(label: label, year: year, speed: speed) // родит. конструктор
    }
    func trunkLoading(_ theState: TrunkState, loading: Int) { //загружаем/разгружаем
        switch theState {
        case .loadState:
            self.load += loading
        case .unloadState:
            self.load -= loading
        }
        if loading < 0 {
            print("ERROR, возврат на прошлое состояние груза")
            self.load = 0
        } else if self.load > 0 {
            print("текущий груз \(label) \(year) года составляет \(load) из \(capacity)\n==========")
        } else {
            self.load = 0
        }
    }
    override func getInfo() { // переопредеояем вывод информации о грузовике
        print("Грузовик \(label) \(year) года с \(self.capacity - self.load) свободного места из \(capacity) скорость \(speed) км/ч \n")
    }
    override func speedControl(speedLimit: Bool, newSpeedAdd: Int) -> Int { // переопределяем контроль скорости для грузовика
        print("скорость будет стандартная ")
        speed = 70
        return speed
    }
}
class SportCar: Car {
    var engineState: EngineState
    var doorState: DoorState {
        willSet {
            if newValue == .close {
                print("У \(label) двери можно открыть ")
            }
            else {
                print("У \(label) двери можно закрыть ")
            }
        }
    }
    enum EngineState {
        case on, off
    }
    enum DoorState {
        case open, close
    }
    init(label: String, year: Int, speed: Int, engineState: EngineState, doorState: DoorState) {
        self.engineState = engineState
        self.doorState = doorState
        super.init(label: label, year: year, speed: speed)
    }
    func openDoor() {
        self.doorState = .open
    }
    func closeDoor() {
        self.doorState = .close
    }
    override func getInfo() {
        print("У \(label) скорость \(speed) км/ч ")
    }
    func printInfo() {
        print("СпортКар \(label) \(year) года, двигатель \(engineState), состояние дверей \(doorState)")
    }
    override func speedControl (speedLimit: Bool, newSpeedAdd: Int) -> Int{ //переопределяем функцию контроля скорости Car для спорткара
        switch speedLimit {
        case false:
            if newSpeedAdd < 200 {
                self.speed -= newSpeedAdd
                print("скорость \(label) снижается до \(speed) км/ч ")
            } else {
                print("\n--------Такую скорость добавить нельзя--------\n")
            }
        case true:
            if newSpeedAdd > 5 {
                print("\(label) идет на разгон со скоростью \(speed) км/ч ")
                self.speed += newSpeedAdd
            } else {
                print("\n--------Слишком мало, можно ускорится сильнее--------\n")
            }
        }
        return speed
    }
}
var truck1 = TruckCar(label: "DhL", year: 1994, capacity: 400, speed: 50, load: 0, trunkState: .loadState)
var truck2 = TruckCar(label: "Schneider", year: 2000, capacity: 1000, speed: 60, load: 300, trunkState: .unloadState)


var sportCar1 = SportCar(label: "Lambo", year: 2018, speed: 100, engineState: .off, doorState: .close)
var sportCar2 = SportCar(label: "Ferrari", year: 2016, speed: 400, engineState: .on, doorState: .open)

// выводим информацию гонок спортКарах
print("\n--------В заезде участвуют:--------\n")
sportCar1.printInfo()
sportCar2.printInfo()
print("---------------------------------------")
sportCar1.openDoor()
sportCar2.closeDoor()
print("---------------------------------------")

sportCar1.getInfo()
sportCar1.speedControl(speedLimit: false, newSpeedAdd: 60)
sportCar1.getInfo()
sportCar1.speedControl(speedLimit: false, newSpeedAdd: 300)
sportCar1.getInfo()
sportCar1.speedControl(speedLimit: true, newSpeedAdd: 30)
sportCar1.getInfo()
sportCar1.speedControl(speedLimit: true, newSpeedAdd: 300)
sportCar1.getInfo()
sportCar1.speedControl(speedLimit: true, newSpeedAdd: 2)
sportCar2.getInfo()
sportCar2.speedControl(speedLimit: true, newSpeedAdd: 46)
sportCar2.getInfo()
sportCar2.speedControl(speedLimit: true, newSpeedAdd: 8)
sportCar2.getInfo()
sportCar2.speedControl(speedLimit: true, newSpeedAdd: 200)
sportCar2.getInfo()

//информация о нагрузке/разгрузке для грузовых машин
print("\n==============Грузовики==============\n")
truck1.getInfo()
truck1.trunkLoading(.loadState, loading: 50)
truck1.trunkLoading(.loadState, loading: 600)

truck2.getInfo()
truck2.trunkLoading(.unloadState, loading: 800)
truck2.getInfo()
truck2.trunkLoading(.loadState, loading: 400)
truck2.getInfo()

//подсчет экземпляров класса Car
var truck3: TruckCar? = TruckCar(label: "Lorry", year: 2006, capacity: 500, speed: 60, load: 60, trunkState: .loadState)
truck3?.speedControl(speedLimit: true, newSpeedAdd: 60) // проверим работу переопределенной фунцкии для грузовика
truck3?.getInfo() // меняется на стандартную скорость 70
print(Car.carCount)
truck3 = nil
print(Car.carCount)

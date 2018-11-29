import UIKit
//1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

enum EngineState { // состояник двигателя
    case on, off
}
enum WindowState { // состояние окон
    case open, close
}
enum TrunkState { // состояние багажника
    case load, unload
}
struct SportCar {
    let label: String
    let year: Int
    let trunkCapacity: Int
    var trunkLoad: Int
    var engineState: EngineState
    var trunkState: TrunkState
    var windowState: WindowState
    func getInfo() {
        print("\(label) \(year) вместимость \(trunkCapacity) , груз \(trunkLoad) , состояние двигателя \(engineState) , состояние окон \(windowState)")
    }
}
struct Truck { //грузовик
    let label: String
    let year: Int
    let trunkCapacity: Int
    var trunkLoad: Int {
        didSet { //проверка после загрузки
            if trunkCapacity < trunkLoad || trunkCapacity <  self.trunkCapacity - self.trunkLoad || trunkCapacity < oldValue {
                print("------------------\n Перегруз! : ")
            }
        }
    }
    var trunkState: TrunkState
    var engineState: EngineState
    var windowState: WindowState { // состояние окон до действий
        willSet {
            if newValue == .close {
                print("(У \(label) окна можно открыть ")
            }
            else {
                print("У \(label) окна можно закрыть ")
            }
        }
    }
    mutating func closeWindow() { // закрыть окно
        self.windowState = .close
    }
    mutating func openWindow() { //открыть окно
        self.windowState = .open
    }
    mutating func engineSwitch(currentState: EngineState) { // изменяем поведение двигателя
        switch currentState {
        case .off:
            self.engineState = .off
            print("Двигатель выкл")
        case .on:
            self.engineState = .on
            print("Двигатель вкл")
        }
    }
    mutating func trunkLoading(_ theState: TrunkState,_ theLoad: Int) { //загружаем/разгружаем
        switch theState {
        case .load:
            self.trunkLoad += theLoad
        case .unload:
            self.trunkLoad -= theLoad
        }
        if theLoad < 0 && trunkLoad < self.trunkCapacity - self.trunkLoad {
            print("error ")
        } else {
           print("\(label) \(year) года загружен на \(trunkLoad) из \(trunkCapacity) ")
        }
}
    func printTrunkState(){ // вывод свободного места
        let result  = self.trunkCapacity - self.trunkLoad
        if result > 0 {
            print("\(label) \(year) года осталось \(result) свободного места ")
        } else {
            print("Места не осталось, перегруз составляет \(abs(result)) ")
        }
    }
    func getInfo() {
        print("\(label) \(year) вместимость \(trunkCapacity) , груз \(trunkLoad) , состояние двигателя \(engineState) , состояние окон \(windowState)")
    }
}
var car1 = SportCar(label: "Lambo", year: 2018, trunkCapacity: 4, trunkLoad: 7, engineState: .on, trunkState: .unload, windowState: .open)
var car2 = SportCar(label: "Ferrari", year: 2016, trunkCapacity: 6, trunkLoad: 7, engineState: .off, trunkState: .load, windowState: .open)
var truck1 = Truck(label: "Schneider", year: 1998, trunkCapacity: 400, trunkLoad: 50, trunkState: .load, engineState:.on, windowState: .close)
var truck2 = Truck(label: "TruckDhL", year: 2006, trunkCapacity: 200, trunkLoad: 0, trunkState: .unload, engineState: .off, windowState: .open)

//экземпляры
print("\n ============================= \n")
car1.getInfo()
car1.windowState = .close
car2.getInfo()
car2.engineState = .off
print("\n ============================= \n")
truck1.getInfo()
truck1.openWindow()
truck1.engineSwitch(currentState: .on)
truck1.printTrunkState()
truck1.getInfo()
print("\n ============================= \n")
truck2.getInfo()
truck2.trunkLoading(.load, 70)
truck2.printTrunkState()
truck2.trunkLoading(.load, 600)
truck2.printTrunkState()


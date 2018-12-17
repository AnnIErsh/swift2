import UIKit


enum TheCarCanNotGo: Error {
    case theTankIsEmpty (tankFillingNeeded: Double) // бак пуст -> машина не поедет
    case theCarIsDestroyed // машину сломали -> машина не поедет
    case theDriverIsNotFound
    case theWrongDriver// нет водителя
}


extension TheCarCanNotGo: CustomStringConvertible {
    var description: String {
        switch self {
        case .theTankIsEmpty (let tankFillingNeeded): return "Недостаточно бензина. нужно \(String(format: "%.2f",tankFillingNeeded)) литров. Машина не поедет"
        case .theCarIsDestroyed: return "Вы сломали машину. Машина не поедет \n"
        case .theDriverIsNotFound: return "Водителя нет. Машина не поедет \n"
        case .theWrongDriver: return "В машине чужой водитель. Машина не поедет \n "
        }
    }
}



struct Driver {
    let name: String
}

struct Car {
    let carName: String
    var driver: Driver?
    let speedLimit: Double = 350
    var speed: Double
    var time: Double
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

    
    var capacity: Double
    var consumption: Double // расход бензина за 1 км
    
    var velocity: Double { //конечная скрорость, вычисляемая
        get {return speed + acceleration * time }
        set {return acceleration = (newValue - speed) / time}
    }
    
    func displacement() -> Double{ // перемещение
        return acceleration * pow(time, 2) / 2 + velocity * time
    }
    
    func petrolUsing() throws -> Double{
        let currentConsumption = displacement() * consumption
        guard capacity > currentConsumption else {
            throw TheCarCanNotGo.theTankIsEmpty(tankFillingNeeded: abs(capacity - currentConsumption))
        }
        return currentConsumption
    }
    
    mutating func speedRate(_ speed: Double, velocity: Double) throws { // превышение допустимой скорости ломает машину
        guard speed < speedLimit || velocity <= speedLimit else{
            throw TheCarCanNotGo.theCarIsDestroyed
        }
    }
}

extension Car: CustomStringConvertible {
    var description: String {
        return "Автомобиль \(carName), дистанция: \(String(format:"%.2f", displacement())), скорость(нач.): \(speed) m/sec, время: \(time) sec, ускорение: \(String(format: "%.2f", acceleration)) m/sec^2 , скорость(кон.): \(String(format: "%.2f", velocity)) m/sec \n"
    }
}



class CarTrace {
    
    var trace = [
        "Alex": Car(carName: "Lambo", driver: Driver(name: "Alex"), speed: 300, time: 10.0, acceleration: 3, capacity: 50, consumption: 0.01),
        "Jon": Car(carName: "Ferrari", driver: Driver(name: "Jon"), speed: 250.5, time: 10.0, acceleration: 4, capacity: 60, consumption: 0.03),
        "Leo": Car(carName: "Porsche", driver: Driver(name: "Leo"), speed: 200, time: 2, acceleration: -4, capacity: 70, consumption: 0.02)
    ]
    func whereTheDriverIs(driver: Driver?) throws { // без водителя машина не поедет
        guard driver != nil else{
            throw TheCarCanNotGo.theDriverIsNotFound
        }
    }
    
    func drive(driver name: String) throws -> Car{
        // если не тот водитель, возвращаем nil
        guard let drivers = trace[name] else {
            throw TheCarCanNotGo.theWrongDriver
        }
        return drivers
    }
}


var trace1 = CarTrace().trace
print(trace1)

trace1["Alex"]!.acceleration = 6 // изменим ускорение в текущем заезде

print(trace1["Alex"]!.acceleration)
print(trace1) // все работает, машина разгоняется


var trace2 = CarTrace().trace

do {
    _ = try trace2["Leo"]!.speedRate(600, velocity: 500) // водитель Leo превышает лимитированную скорость и машина не едет
}
catch let err as TheCarCanNotGo {
    print(err.description)
}


let trace3 = CarTrace()
do {
    _ = try CarTrace().drive(driver: "Oleg") // сел чужой водитель и машина не поедет
} catch let err as TheCarCanNotGo {
    print(err.description)
}


let trace4 = CarTrace()
do {
    _ = try trace4.whereTheDriverIs(driver: nil) // водителя нет. машина не поедет
} catch let err as TheCarCanNotGo {
    print(err.description)
}

let check1 = trace4.trace["Jon"]!.capacity // литры в баке
print(check1)

do {
    _  = try CarTrace().trace["Jon"]!.petrolUsing() // проверка на наличие бензина
} catch let err as TheCarCanNotGo {
    print(err.description)
}

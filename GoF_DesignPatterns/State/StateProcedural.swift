import Foundation

enum Event: Int {
    case coin100 = 1, coin200, redButton, greenButton, quit
}

enum MachineState {
    case idle, has100, has200
}

func main() { 
    print("Bienvenido. Tenemos dos productos: A y B.")
    var state = MachineState.idle
    
    while true {
        let event = getEvent()
        guard event != Event.quit else {
            print("Adiós.")
            break
        }

        switch state {
            case .idle:
                idleStateProcess(event: event, state: &state)
            case .has100:
                has100StateProcess(event: event, state: &state)
            case .has200:
                has200StateProcess(event: event, state: &state)
        }

        print(currentState: state)
    }
}

func idleStateProcess(event: Event, state: inout MachineState) {
    switch event {
        case .coin100:
            state = MachineState.has100
        case .coin200:
            state = MachineState.has200
        case .greenButton, .redButton:
            // Do nothing
            break
        case .quit:
            print("Evento inválido")
    }
}

func has100StateProcess(event: Event, state: inout MachineState) {
    switch event {
        case .coin100:
            state = MachineState.has200
        case .coin200:
            state = MachineState.has200
            print("Devolviendo 100...")
        case .greenButton, .redButton:
            // Do nothing
            break
        case .quit:
            print("Evento inválido")
    }
}

func has200StateProcess(event: Event, state: inout MachineState) {
    switch event {
        case .coin100:
            print("Devolviendo 100...")
        case .coin200:
            print("Devolviendo 200...")
        case .redButton:
            state = .idle
            print("Entregando producto A")
        case .greenButton:
            state = .idle
            print("Entregando producto B")
        case .quit:
            print("Evento inválido")
    }
}

func print(currentState: MachineState) {
    switch currentState {
        case .idle:
            print("\nNo hay monedas almacenadas. Inserte una moneda de 100 o 200 para continuar...\n")
        case .has100:
            print("\nHay 100 pesos almacenados. Inserte una moneda de 100 o 200 para continuar...\n")
        case .has200:
            print("\nHay 200 pesos almacenados. Inserte una moneda de 100 o 200, o presione el botón rojo o verde para continuar...\n")
    }
}

func getEvent() -> Event {
    let possibleOptions = [1, 2, 3, 4, 5]
    var validOption = false
    var option = -1
    repeat {
        print("\n1. Insertar moneda de 100")
        print("2. Insertar moneda de 200")
        print("3. Presionar botón rojo (A)")
        print("4. Presionar botón verde (B)")
        print("5. Salir")
        option = Int(readLine()!) ?? -1
        validOption = possibleOptions.contains(option)
        if !validOption {
            print("Opción inválida")
        }
    } while !validOption
    return Event(rawValue: option)!
}

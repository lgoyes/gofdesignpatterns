import Foundation

protocol State {
    func coin100In()
    func coin200In()
    func redButtonPressed()
    func greenButtonPressed()
    func getDescription() -> String
}

protocol Has100StateMovable: AnyObject {
    func moveToHas100State()
}

protocol Has200StateMovable: AnyObject {
    func moveToHas200State()
}

protocol IdleStateMovable: AnyObject {
    func moveToIdleState()
}

class Has100State: State {
    weak var delegate: Has200StateMovable?
    func coin100In() {
        delegate?.moveToHas200State()
    }
    func coin200In() {
        delegate?.moveToHas200State()
        print("Devolviendo 100...")
    }
    func redButtonPressed() {
        // Do nothing
    }
    func greenButtonPressed() {
        // Do nothing
    }
    func getDescription() -> String {
        "\nHay 100 pesos almacenados. Inserte una moneda de 100 o 200 para continuar...\n"
    }
}

class Has200State: State {
    weak var delegate: IdleStateMovable?
    func coin100In() {
        print("Devolviendo 100...")
    }
    func coin200In() {
        print("Devolviendo 200...")
    }
    func redButtonPressed() {
        delegate?.moveToIdleState()
        print("Entregando producto A")
    }
    func greenButtonPressed() {
        delegate?.moveToIdleState()
        print("Entregando producto B")
    }
    func getDescription() -> String {
        "\nHay 200 pesos almacenados. Inserte una moneda de 100 o 200, o presione el botón rojo o verde para continuar...\n"
    }
}

class IdleState: State {
    weak var delegate: (Has200StateMovable & Has100StateMovable)?
    func coin100In() {
        delegate?.moveToHas100State()
    }
    func coin200In() {
        delegate?.moveToHas200State()
    }
    func redButtonPressed() {
        // Do nothing
    }
    func greenButtonPressed() {
        // Do nothing
    }
    func getDescription() -> String {
        "\nNo hay monedas almacenadas. Inserte una moneda de 100 o 200 para continuar...\n"
    }
}

class Context {
    private var currentState: State
    private var has100State: State
    private var has200State: State
    private var idleState: State
    init(currentState: State, has100State: State, has200State: State, idleState: State) {
        self.currentState = currentState
        self.has100State = has100State
        self.has200State = has200State
        self.idleState = idleState
    }
    func coin100In() {
        currentState.coin100In()
    }
    func coin200In() {
        currentState.coin200In()
    }
    func redButtonPressed() {
        currentState.redButtonPressed()
    }
    func greenButtonPressed() {
        currentState.greenButtonPressed()
    }
    func print() {
        Swift.print(currentState.getDescription())
    }
}

extension Context: Has100StateMovable, Has200StateMovable, IdleStateMovable {
    func moveToHas100State() {
        currentState = has100State
    }

    func moveToHas200State() {
        currentState = has200State
    }

    func moveToIdleState() {
        currentState = idleState
    }
}

class ContextFactory {
    static func create() -> Context {
        let has100State = Has100State()
        let has200State = Has200State()
        let idleState = IdleState()

        let context = Context(currentState: idleState, has100State: has100State, has200State: has200State, idleState: idleState)
        
        has100State.delegate = context
        has200State.delegate = context
        idleState.delegate = context
        
        return context
    }
}

fileprivate class Client {
    enum Option: Int {
        case coin100 = 1, coin200, redButton, greenButton, quit
    }
    let context = ContextFactory.create()
    func main() { 
        print("Bienvenido. Tenemos dos productos: A y B.")
        while true {
            let option = getOption()
            guard option != Option.quit else {
                print("Adiós.")
                break
            }
            switch option {
                case .coin100:
                    context.coin100In()
                case .coin200:
                    context.coin200In()
                case .redButton:
                    context.redButtonPressed()
                case .greenButton:
                    context.greenButtonPressed()
                case .quit:
                    break
            }
            context.print()
        }
    }

    func getOption() -> Option {
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
        return Option(rawValue: option)!
    }
}

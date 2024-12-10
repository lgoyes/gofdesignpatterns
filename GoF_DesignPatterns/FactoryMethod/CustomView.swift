//
//  CustomView.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 10/12/24.
//

class View {
    func load() {
        
    }
    func set(color: String) {
        
    }
    func add(subview: View) {
        
    }
}

class Dialog: View {
    func set(title: String) {}
}
class Label: View {
    func set(text: String) {}
}
class TextField: View {
    func set(placeholder: String) {}
}

class CustomView: View {
    private let type: String
    private let color: String
    private let text: String
    
    init(type: String, color: String, text: String) {
        self.type = type
        self.color = color
        self.text = text
    }
    
    override func load() {
        let view: View?

        if (type == "dialog") {
            let dialog = Dialog()
            dialog.set(title: text)
            view = dialog
        } else if (type == "label") {
            let label = Label()
            label.set(text: text)
            view = label
        } else if (type == "textfield") {
            let textField = TextField()
            textField.set(placeholder: text)
            view = textField
        } else {
            view = nil
        }
        
        if let view {
            add(subview: view)
            view.set(color: color)
            view.load()
        }
    }
}



//
//  MagicView.swift
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
    func set(title: String) {
        
    }
}
class Label: View {
    func set(text: String) {
        
    }
}
class TextField: View {
    func set(placeholder: String) {
        
    }
}

class MagicView: View {
    let color: String
    let text: String
    
    init(color: String,
        text: String) {
        self.color = color
        self.text = text
    }
    
    override func load() {
        if let view = createView() {
            add(subview: view)
            view.set(color: color)
            view.load()
        }
    }
    func createView() -> View? {
        nil
    }
}

class DialogMagicView: MagicView {
    override func createView() -> View? {
        let dialog = Dialog()
        dialog.set(title: text)
        return dialog
    }
}

class LabelMagicView: MagicView {
    override func createView() -> View? {
        let label = Label()
        label.set(text: text)
        return label
    }
}

class TextFieldMagicView: MagicView {
    override func createView() -> View? {
        let textField = TextField()
        textField.set(placeholder: text)
        return textField
    }
}

class MagicViewFactory {
    func create(type: String,
                color: String,
                text: String) -> MagicView? {
        switch type {
        case "dialog":
            return DialogMagicView(
                color: color,
                text: text)
        case "label":
            return LabelMagicView(
                color: color,
                text: text)
        case "textfield":
            return TextFieldMagicView(
                color: color,
                text: text)
        default:
            return nil
        }
    }
}

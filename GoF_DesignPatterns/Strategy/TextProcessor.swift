//
//  TextProcessor.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 22/11/24.
//

// MarkDown: ["uno", "dos", "tres"]
//
// * uno
// * dos
// * tres
//
// HTML: ["uno", "dos", "tres"]
// <ul>
//  <li>uno</li>
//  <li>dos</li>
//  <li>tres</li>
// </ul>
//

enum OutputFormat {
    case markdown, html
}

protocol FormatStrategy {
    func start(_ buffer: inout String)
    func add(item: String, to buffer: inout String)
    func end(_ buffer: inout String)
}

class MarkdownFormatStrategy: FormatStrategy {
    func start(_ buffer: inout String) {}
    func add(item: String, to buffer: inout String) {
        buffer.append(" * \(item)\n")
    }
    func end(_ buffer: inout String) {}
}

class HtmlFormatStrategy: FormatStrategy {
    func start(_ buffer: inout String) {
        buffer.append("<ul>\n")
    }
    func add(item: String, to buffer: inout String) {
        buffer.append(" <li>\(item)</li>\n")
    }
    func end(_ buffer: inout String) {
        buffer.append("</ul>\n")
    }
}

class TextProcessor: CustomStringConvertible {
    private var buffer = ""
    private var formatStrategy: FormatStrategy
    init(formatStrategy: FormatStrategy) {
        self.formatStrategy = formatStrategy
    }
    func setFormatStrategy(_ formatStrategy: FormatStrategy) {
        self.formatStrategy = formatStrategy
    }
    func append(items: [String]) {
        formatStrategy.start(&buffer)
        items.forEach { item in
            formatStrategy.add(item: item, to: &buffer)
        }
        formatStrategy.end(&buffer)
    }
    func clear() {
        buffer = ""
    }
    var description: String {
        buffer
    }
}

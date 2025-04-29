//
//  Memento.swift
//  GoF_DesignPatterns
//
//  Created by Luis David Goyes Garces on 29/4/25.
//

class ChessGame {
    let board: BoardAbstraction
    var history: [BoardMementoAbstraction]
    init(board: BoardAbstraction, history: [BoardMementoAbstraction]) {
        self.board = board
        self.history = history
    }
    
    func play(white: Bool, piece: ChessPieceType, destination: PiecePosition) {
        let memento = board.save()
        history.append(memento)
        let moveDescription = board.move(white: white, piece: piece, destination: destination)
        print(moveDescription)
    }
    
    func undo() {
        if let lastMove = history.popLast() {
            lastMove.restore()
        }
    }
}

protocol BoardMementoAbstraction {
    func restore()
}

protocol BoardOriginator {
    func save() -> BoardMementoAbstraction
}

protocol BoardAbstraction: BoardOriginator {
    func move(white: Bool, piece: ChessPieceType, destination: PiecePosition) -> String
}

class ChessBoard: BoardOriginator {
    var pieces: [ChessPiece]
    init(pieces: [ChessPiece]) {
        self.pieces = pieces
    }
    func move(white: Bool, piece: ChessPieceType, destination: PiecePosition) -> String {
        // some logic
        return "Be4"
    }
    
    func save() -> any BoardMementoAbstraction {
        return ChessBoardMemento(pieces: pieces, originator: self)
    }
    
    func set(pieces: [ChessPiece]) {
        self.pieces = pieces
    }
}

struct ChessBoardMemento: BoardMementoAbstraction {
    let pieces: [ChessPiece]
    let originator: ChessBoard
    
    func restore() {
        originator.set(pieces: pieces)
    }
}

enum ChessPieceType {
    case king, queen, rook, bishop, knight, pawn
}

struct PiecePosition {
    let row: Int
    let column: Int
}

class ChessPiece {
    let white: Bool
    let type: ChessPieceType
    var position: PiecePosition
    init(white: Bool, type: ChessPieceType, position: PiecePosition) {
        self.white = white
        self.type = type
        self.position = position
    }
}

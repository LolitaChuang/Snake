//
//  SnakeModel.swift
//  Snake
//
//  Created by Lolita Chuang on 2017/2/3.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import Foundation

class Snake {
    struct Position : Equatable {
        var x:Int
        var y:Int
        
        init(x:Int, y:Int) {
            self.x = x
            self.y = y
        }
        
        // 加static的意義是? Ans : 因為這是一個type method, 之中的Self(Position)指目前的type
        static func ==(lhs:Position, rhs:Position) -> Bool { // implement protocol要將Self改為目前的型別
            return ((lhs.x == rhs.x) && (lhs.y == rhs.y))
        }
    }
    
    enum Direction {
        case up
        case down
        case left
        case right
    }
    
    var body = Array<Position>() // 注意array的初始化, 以struct為element的初始化 // 若要讓其read-only?
    var length:Int {
        get {
            return body.count
        }
    }
    
    var head:Position { // computed property with struct
        get {
            return body[0]
        }
    }
    
    private var newHead:Position { // 一直重複被計算?
        var newHead:Position
        
        switch (self.direction) { // 注意enum的運算
        case .up : newHead = Position(x:head.x, y:head.y+1)
        case .down : newHead = Position(x:head.x, y:head.y-1)
        case .left : newHead = Position(x:head.x-1, y:head.y)
        case .right : newHead = Position(x:head.x+1, y:head.y)
        }

        newHead = rearrangePositionWithBorder(point: newHead)
        return newHead
    }
    
    private var tail:Position {
        get {
            return body.last!
        }
    }
    
    var direction:Direction = .left
    var border:Position
    
    init(head:Position, border:Position) {
        body.append(head)
        body.append(Position(x:head.x+1, y:head.y))
        
        self.border = border
    }
    
    func move() {
        body.insert(newHead, at: 0)
        body.removeLast()
    }
    
    func extend() -> Bool {
        // append 2 more elements according to the direction
        var offset:Position
        
        switch (self.direction) { // 注意enum的運算
        case .up : offset = Position(x:0, y:-1)
        case .down : offset = Position(x:0, y:1)
        case .left : offset = Position(x:1, y:0)
        case .right : offset = Position(x:1, y:0)
        }
        
        for _ in 0..<2 {
            let newTail = rearrangePositionWithBorder(point: Position(x:tail.x+offset.x, y:tail.y+offset.y))
            body.append(newTail)
            if isHeadCollidTail() {
                return false
            }
        }
        
        return true
    }
    
    private func isHeadCollidTail() -> Bool {
        // 新head==舊tail
        return (newHead == tail) // compiler error "Binary operator '==' cannot be applied to two 'Snake.Position' =operands"? Ans:因為需要先confirm Equatable protocol
    }
    
    private func rearrangePositionWithBorder(point:Position) -> Position {
        var newPoint = point
        if (newPoint.x < 0) {
            newPoint.x = newPoint.x + border.x
        } else if (newPoint.x > border.x) {
            newPoint.x = newPoint.x - border.x
        }
        
        if (newPoint.y < 0) {
            newPoint.y = newPoint.y + border.y
        } else if (newPoint.y > border.y) {
            newPoint.y = newPoint.y - border.y
        }
        
        return newPoint
    }
}

//
//  SnakePlaygroundView.swift
//  Snake
//
//  Created by Lolita Chuang on 2017/2/4.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

class SnakePlaygroundView: UIView {

    //var delegate:AnyObject // 錯誤的delegate宣告
    var delegate:SnakePlaygroundViewDelegate?
    var dataSource:SnakePlaygroundViewDataSource?
    
    
    override init(frame: CGRect) {
        // 利用code產生的view
        fatalError("init(coder:) has not been implemented")
    }
    
    // subclass需要提供?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 注意selector的寫法
        // workaround of 'swipeGestureRecognizer.direction = [.up, .down, .left, .right]' not work
        let directions = [UISwipeGestureRecognizerDirection.down, UISwipeGestureRecognizerDirection.up, UISwipeGestureRecognizerDirection.left, UISwipeGestureRecognizerDirection.right]
        
        for direction in directions {
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(getSwipeEvent(recognizer:)))
            swipeGestureRecognizer.direction = direction
            self.addGestureRecognizer(swipeGestureRecognizer)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    
    // 和drawRect有何不同?
    override func draw(_ rect: CGRect) {
        //print("draw........")
        
        if let body = dataSource?.snakeBody {
            for point in body {
                let beizerPath = UIBezierPath(ovalIn: CGRect(x: point.x-1/2, y: point.y-1/2, width: 1, height: 1))
                UIColor.red.setFill()
                beizerPath.fill()
            }
        }

    }
    
    // 注意GestureRecognizer's selector寫法
    func getSwipeEvent(recognizer: UISwipeGestureRecognizer) {
        delegate?.swipe(to: recognizer.direction)
    }

}

protocol SnakePlaygroundViewDelegate {
    func swipe(to:UISwipeGestureRecognizerDirection)
}

protocol SnakePlaygroundViewDataSource {
    // view應該不知道model的資料格式, 他只想知道CGPoint...所以該由誰提供格式轉換?
    var snakeBody:Array<CGPoint>? {get}
}
/* 錯誤的寫法
extension SnakePlaygroundView : SnakePlaygroundViewDelegate {
    
}
*/

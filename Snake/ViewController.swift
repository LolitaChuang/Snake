//
//  ViewController.swift
//  Snake
//
//  Created by Lolita Chuang on 2017/2/3.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var playgroundView: SnakePlaygroundView!
    @IBOutlet weak var startButton: UIButton!
    var snake:Snake! // lazy must have an initializer?
    var timer:Timer! // 注意timer's runloop

    @IBAction func startGame(_ sender: Any) {
        startButton.isHidden = true
        RunLoop.main.add(timer, forMode: RunLoopMode.defaultRunLoopMode) // 自己會fire?
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // playgroundView.delegate = self as! SnakePlaygroundViewDelegate // 建議寫成下一行, 因為Forced cast from 'ViewController' to 'SnakePlaygroundViewDelegate' always succeed // as, as?, as!的差別和使用的時機?
        playgroundView.delegate = self as SnakePlaygroundViewDelegate
        playgroundView.dataSource = self as SnakePlaygroundViewDataSource
        
        snake = Snake(head:Snake.Position(x:Int(self.view.center.x), y:Int(self.view.center.y)),
                      border:Snake.Position(x:Int(self.view.bounds.maxX), y:Int(self.view.bounds.maxY)))
        // fruit
        
        // prepare Timer 需要自己將timer加入runloop
        timer = Timer(timeInterval: 0.5, repeats: true, block: { (timerParameter) in
            // timer's block是在哪個thread?
            DispatchQueue.main.async {
                //print("timer....")
                
                self.snake.move()
                /*
                if self.snake.head == fruit {
                    if self.snake.extend() {
                        self.view.setNeedsDisplay()
                    } else {
                        //fail
                    }
                }
                */
                self.view.setNeedsDisplay()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        if view.window == nil {
            view = nil
        }
    }
}


extension ViewController: SnakePlaygroundViewDelegate {
    func swipe(to: UISwipeGestureRecognizerDirection) {
        //print("swipe......")
        
        switch (snake.direction) {
        case .left, .right :
            if (to == UISwipeGestureRecognizerDirection.up) {
                snake.direction = .up
            } else if (to == UISwipeGestureRecognizerDirection.down) {
                snake.direction = .down
            }
        case .down, .up:
            if (to == UISwipeGestureRecognizerDirection.right) {
                snake.direction = .right
            } else if (to == UISwipeGestureRecognizerDirection.left) {
                snake.direction = .left
            }
        }
    }
}

extension ViewController: SnakePlaygroundViewDataSource {
    var snakeBody:Array<CGPoint>? {
        get {
            var body = Array<CGPoint>()
            
            for position in snake.body {
                let point = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
                body.append(point)
            }
            
            return body
        }
        
        set { //有set就一定要有get, 不能單獨存在; 但protocol得宣告只有get, 這裡為什麼能定義set? => If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it is valid for the property to be also settable if this is useful for your own code.
            
        }
    }
}

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
        snake = Snake(head:Snake.Position(x:Int(self.view.center.x), y:Int(self.view.center.y)),
                      border:Snake.Position(x:Int(self.view.bounds.maxX), y:Int(self.view.bounds.maxY)))
        // fruit
        
        // prepare Timer 需要自己將timer加入runloop
        timer = Timer(timeInterval: 0.5, repeats: true, block: { (timerParameter) in
            // timer's block是在哪個thread?
            DispatchQueue.main.async {
                print("timer....")
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
        print("swipe......")
    }
}

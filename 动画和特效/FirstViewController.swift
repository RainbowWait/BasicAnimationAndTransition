//
//  FirstViewController.swift
//  动画和特效
//
//  Created by 郑小燕 on 2017/12/20.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var myLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red
        self.myLayer = CALayer()
        myLayer.frame = CGRect(x: 10, y: 200, width: 100, height: 100)
        myLayer.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(self.myLayer)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    @objc func tapAction(_ tapGesture: UITapGestureRecognizer) {
        CATransaction.begin()
        //关闭隐式动画,这句话必须放在修改属性之前
//        CATransaction.setDisableActions(true)
        //设置动画执行时间
        CATransaction.setAnimationDuration(2)
        self.myLayer.backgroundColor = UIColor.green.cgColor
        self.myLayer.opacity = 0.5
        var moveToPoint  = CGPoint(x: myLayer.position.x + 50, y: myLayer.position.y + 50)
        if(moveToPoint.x > view.frame.size.width) { moveToPoint.x -= view.frame.size.width}
        if(moveToPoint.y > view.frame.size.height) { moveToPoint.y -= view.frame.size.height}
        self.myLayer.position = moveToPoint
        CATransaction.commit()
        perform(#selector(pause), with: nil, afterDelay: 0.2)
        //设置动画完成后的回调
        CATransaction.setCompletionBlock {
            print("动画完成")
        }
    }
    //动画暂停
    @objc func pause() {
        let interval = myLayer.convertTime(CACurrentMediaTime(), from: nil)
        myLayer.timeOffset = interval
        myLayer.speed = 0
        perform(#selector(resume), with: nil, afterDelay: 2)
    }
    //动画继续
    @objc func resume() {
        let interval = CACurrentMediaTime() - myLayer.timeOffset
        myLayer.timeOffset = 0
        myLayer.beginTime = interval
        myLayer.speed = 1
        
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        self.dismiss(animated: true
////            , completion: nil)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

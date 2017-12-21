//
//  SecondViewController.swift
//  动画和特效
//
//  Created by 郑小燕 on 2017/12/20.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    //放射
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
//        self.example1()
        self.example2()
    }
    
    func example1() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {
            //平移
            let translate = CGAffineTransform(translationX: 0, y: 300)
            //旋转
            let rote = CGAffineTransform(rotationAngle: 15 * CGFloat.pi / 18)
            self.view.transform = translate.concatenating(rote)
            
            
        }, completion: nil)
    }
    
    func example2() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {
            //平移
            let translate = CGAffineTransform(translationX: 110, y: 0)
            //旋转
            let scale = CGAffineTransform(scaleX: 0.8, y:0.8)
            self.view.transform = translate.concatenating(scale)
            
            
        }, completion: nil)
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.navigationController?.popViewController(animated: true)
    }
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

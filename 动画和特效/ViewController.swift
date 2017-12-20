//
//  ViewController.swift
//  动画和特效
//
//  Created by 郑小燕 on 2017/12/20.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnAction1(_ sender: Any) {
        let toVC = FirstViewController()
        toVC.transitioningDelegate = self
        navigationController?.present(toVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func btnAction2(_ sender: UIButton) {
        let toVC = SecondViewController()
        navigationController?.delegate = self
//        transitioningDelegate = sender
        navigationController?.pushViewController(toVC, animated: true)
        
    }
    
    
    @IBAction func btnAction3(_ sender: Any) {
    }
    
    
    @IBAction func btnAction4(_ sender: Any) {
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

//MARK: - Present 和 Dismiss过渡效果
//UIViewControllerTransitioningDelegate
extension ViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentedAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
}

public class PresentedAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        //转场过渡动画时间
        return 0.5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //拿到前后的两个controller
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        //拿到Presenting的最终Frame
        let finalFrameForVC = transitionContext.finalFrame(for: toVC!)
        //拿到Presenting的最终Frame
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        toVC?.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: bounds.size.height)
        containerView.addSubview((toVC?.view)!)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            fromVC?.view.alpha = 0.5
            toVC?.view.frame = finalFrameForVC
        }) { (state) in
            transitionContext.completeTransition(true)
            fromVC?.view.alpha = 1.0
        }
    }
}

class DismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let screenBounds = UIScreen.main.bounds
        let initFrame = transitionContext.initialFrame(for: fromVC!)
        let finalFrame = initFrame.offsetBy(dx: 0, dy: screenBounds.size.height)
        let containerView = transitionContext.containerView
        containerView.addSubview((toVC?.view)!)
        containerView.sendSubview(toBack: (toVC?.view)!)
        let duration: TimeInterval = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromVC?.view.frame = finalFrame
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}

//MARK: - push 和 pop过渡动画
extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        let transitioningAnimation = ExpandAnimation(type:operation)
        transitioningAnimation.sender = btn2
        //返回动画的实现类
        return transitioningAnimation
    }
    
}

class ExpandAnimation: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    init(type: UINavigationControllerOperation) {
        super.init()
        self.type = type
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        if self.type == UINavigationControllerOperation.pop {
            
        } else if self.type == UINavigationControllerOperation.push {
            
            
        }
    }
    
    func PopTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        let view = toVC?.view
        containerView.addSubview((toVC?.view)!)
        containerView.addSubview((fromVC?.view)!)
        
        //遮罩层
        let mask = CAShapeLayer()
        fromVC?.view.layer.mask = mask
        //画出小圆
        let s_center = CGPoint(x: 50, y: 50)
        let s_radius: CGFloat = CGFloat(sqrt(800))
        let s_rect = CGRect(x: s_center.x, y: s_center.y, width: 1, height: 1)
        
        let s_maskPath = UIBezierPath(rect: s_rect.insetBy(dx: -s_radius, dy: -s_radius))
//        mask.path = s_maskPath.cgPath
        
        //画大圆
        let l_center = CGPoint(x: 50, y: 50)
        let l_radius = sqrt(pow((view?.bounds.width)! - l_center.x, 2) + pow((view?.bounds.height)! - l_center.y, 2)) + 150
        let l_rect = CGRect(x: l_center.x, y: l_center.y, width: 1, height: 1)
        
        let l_maskPath = UIBezierPath(rect: l_rect.insetBy(dx: -l_radius, dy: -l_radius))
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.duration = transitionDuration(using: transitionContext)
        baseAnimation.fromValue = l_maskPath.cgPath
        baseAnimation.toValue = s_maskPath.cgPath
        baseAnimation.delegate = self as! CAAnimationDelegate
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        mask.add(baseAnimation, forKey: "path")
        
        
        
    }
    
    func PushTransition(transitionContext: UIViewControllerContextTransitioning) {
        let frmoVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let finalFrame = transitionContext.finalFrame(for: toVC!)
        let containerView = transitionContext.containerView
        let view = toVC?.view
        containerView.addSubview((toVC?.view)!)
        //小圆路径
        let s_maskPath = UIBezierPath(ovalIn: (sender?.frame)!)
        //大圆路径
        let l_center = (sender?.center)!
        var l_radius: CGFloat
        if (sender?.frame.origin.x)! > (toVC?.view.bounds.width)! / 2.0 {
            if (sender?.frame.origin.y)! < (toVC?.view.bounds.size.height)! / 2.0 {
                
                //右上角
                l_radius = sqrt(pow(0-l_center.x, 2) + pow((view?.frame.maxY)!-l_center.y, 2))
            } else {
                //右下角
                l_radius = sqrt(pow(0 - l_center.x, 2) + pow(0 - l_center.y, 2))
                
                
            }
            
        } else {
            if (sender?.frame.origin.y)! < (toVC?.view.bounds.size.height)! / 2.0 {
                //左上角
                l_radius = sqrt(pow((view?.frame.maxX)! - l_center.x, 2) + pow((view?.frame.maxY)! - l_center.y, 2))
                
            } else {
                //左下角
                l_radius = sqrt(pow((view?.frame.maxX)! - l_center.x, 2) + pow(0 - l_center.y, 2))
            }
        }
        l_radius += 50
        let l_rect = CGRect(x: l_center.y, y: l_center.y, width: 1, height: 1)
        
        
        let l_maskPath = UIBezierPath(ovalIn: l_rect.offsetBy(dx: -l_radius, dy: -l_radius))
        //遮罩层
        let mask = CAShapeLayer()
        mask.path = l_maskPath.cgPath
        view?.layer.mask = mask
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.duration = transitionDuration(using: transitionContext)
        baseAnimation.fromValue = s_maskPath.cgPath
        baseAnimation.toValue = l_maskPath.cgPath
        baseAnimation.delegate = self
        baseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        mask.add(baseAnimation, forKey: "path")
        
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
      //动画完成后去除遮罩
        self.transitionContext.completeTransition(true)
        //动画完成后去除遮罩
        self.transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
        self.transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.layer.mask = nil
    }
    
    //保存上下文
    var transitionContext: UIViewControllerContextTransitioning!
    //Pop or push
    var type: UINavigationControllerOperation!
    //初始点击的UIView对象,需要他的frame作为初始位置
    var sender: UIView?
    
    
    
}


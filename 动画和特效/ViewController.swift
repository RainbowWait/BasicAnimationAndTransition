//
//  ViewController.swift
//  动画和特效
//
//  Created by 郑小燕 on 2017/12/20.
//  Copyright © 2017年 郑小燕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnAction1(_ sender: Any) {
        let toVC = FirstViewController()
        toVC.transitioningDelegate = self
        navigationController?.present(toVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func btnAction2(_ sender: UIButton) {
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

//
//  JXCoolTransitioningDelegate.swift
//  按钮位置变化
//
//  Created by apple on 16/2/17.
//  Copyright © 2016年 kang. All rights reserved.
//

import UIKit

class JXCoolTransitioningDelegate: NSObject  {
   fileprivate var isPop : Bool = true
    
}

//MARK: delegate - UIViewControllerAnimatedTransitioning
extension JXCoolTransitioningDelegate : UIViewControllerAnimatedTransitioning{
    
    //转场时间
    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        
        return 0.25
    }
    
    
    
    /// 转场动画（主动提供转场动画，一旦实现了这个方法，原有的转场动画失效）
    ///
    /// - Parameter transitionContext: 转场上下文，提供转场动画的相关信息
    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        let fromVc = transitionContext.viewController(forKey: .from)
        let toVc = transitionContext.viewController(forKey: .to)
        
        let animateVc = isPop ? toVc : fromVc
        let animateView = animateVc!.view
        
        
        let transZero = CGAffineTransform(scaleX: 0.8, y: 0.8)
        let midTrans = CGAffineTransform(scaleX: 0.01, y: 0.01)
        let transIty = CGAffineTransform.identity
        
        var damping = 3.0
        
        if isPop {
            transitionContext.containerView.addSubview(animateView!)
            damping = 0.75
        }
        
        animateView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        animateView?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animateView?.center = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.5)
        
        
        animateView?.transform = isPop ?transZero : transIty
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                             delay: 0,
            usingSpringWithDamping: CGFloat(damping),
             initialSpringVelocity: 5.0,
            options: UIViewAnimationOptions.beginFromCurrentState,
            animations: { () -> Void in
                
                animateView?.transform = self.isPop ? transIty : midTrans
               
                if !self.isPop {
                    animateView?.alpha = 0
                }
                
            }) { _ in
                
                if self.isPop == false {
                    animateView?.removeFromSuperview()
                }
                
                //注意：转场动画结束必须写
                transitionContext.completeTransition(true)
           }
      }

}

//MARK: delegate - UIViewControllerTransitioningDelegate (视图控制器专场代理)
extension JXCoolTransitioningDelegate : UIViewControllerTransitioningDelegate{
    
    //调度转场动画的控制器是谁
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{
        
        return JXPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    //返回转场动画代理
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPop = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPop = false
        return self
    }
}


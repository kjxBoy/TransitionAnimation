//
//  JXPresentationController.swift
//  按钮位置变化
//
//  Created by apple on 16/2/17.
//  Copyright © 2016年 kang. All rights reserved.
//

import UIKit

//控制model的展现的Controller
class JXPresentationController: UIPresentationController {
    
    fileprivate lazy var dummyingView:UIView = {
        let backView = UIView()
        
        backView.backgroundColor = UIColor.black
        backView.alpha = 0.4
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tap))
        backView.addGestureRecognizer(tapGes)
        
        return backView
    }()
    
    
    
    //MARK: - 准备dimmimgView
    /// - Parameters:
    ///   - presentedViewController: 要model显示的视图控制器
    ///   - presentingViewController: （文档说）是底层的视图控制器，实测是nil
    //   contaierView 容器视图 （在构造函数中为nil,符合懒加载原则)
    //   presentedView() 被展现的视图
//    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
//        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
//        
//        /**要实现自定义Modal转场
//          1.设置转场代理
//                1>返回UIPresentationController ，由该控制器负责 Modal 界面的处理
//          2.设置Modal的展现方式是自定义
//         */
//    }
    
    
    //MARK: - 改变了ContainerView里面的subView的frame , 但是直接从控制器vc.View的frame没有改变
    //要调用方法"JXCoolTransitioningDelegate里面的transitionContext.finalFrame(for: animateVc!)"来获得相应的frame
    //自定义展现视图的frame
    
    override var frameOfPresentedViewInContainerView : CGRect {
        
        let containerViewRect = self.containerView?.bounds
        var newRect = CGRect.zero
        newRect.size = CGSize(width: containerViewRect!.width * 0.6, height: containerViewRect!.height * 0.6)
        let x = (containerViewRect!.width - newRect.width) * 0.5
        let y = 56.0;
        newRect.origin = CGPoint(x: x, y: CGFloat(y))
        
        return newRect
    }
    
    //在呈现过渡即将开始的时候被调用的
    override func presentationTransitionWillBegin() {
        dummyingView.frame = containerView!.bounds
        containerView?.insertSubview(dummyingView, at: 0)
    }
    
    //在退出过渡即将开始的时候被调用的
    override func dismissalTransitionWillBegin() {
        dummyingView.isHidden = true
    }
    
    
    func tap(){
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}

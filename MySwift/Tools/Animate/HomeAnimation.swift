//
//  HomeAnimation.swift
//  MySwift
//
//  Created by yinhe on 2019/4/17.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit

protocol HomeAnimationPresentDelegate :NSObjectProtocol {
    func presentAnimationView()->UIView
    func presentAnimationFromFrame()->CGRect
    func presentAnimationToFrame()->CGRect
}

protocol HomeAnimationDismissDelegate :NSObjectProtocol {
    func dismissAnimationView()->UIView
    func dismissAnimationFromFrame()->CGRect
    func dismissAnimationToFrame()->CGRect
}

class HomeAnimation: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    
    
    var  isPresent: Bool = true
    
    weak var presentDelegate:HomeAnimationPresentDelegate?
    weak var dismissDelegate:HomeAnimationDismissDelegate?
    
    //弹出动画谁来做
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    //消失动画谁来做
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
    
    //转场动画需要的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3
    }
    //具体怎么做动画
    //Context:上下文
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       //区分弹出消失
        if isPresent{
            presentAnimation(transitionContext: transitionContext)
        }else{
            dismissAnimation(transitionContext: transitionContext)
        }
    }
    
    func presentAnimation(transitionContext: UIViewControllerContextTransitioning){
        
        guard let pD = presentDelegate else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        //从哪里转场到哪里
        //let listView = transitionContext.view(forKey: .from)
        //let detailView = transitionContext.view(forKey: .to)
        
        //1.做动画的视图
        let animationView = pD.presentAnimationView()
        //2.动画起始位置
        let fromFrame = pD.presentAnimationFromFrame()
        //1.动画结束位置
        let toFrame = pD.presentAnimationToFrame()
        
        containerView.addSubview(animationView)
        animationView.frame = fromFrame
        
        //目标控制器的视图，不会在自动添加到containerView里面去了
        let detailView = transitionContext.view(forKey: .to)
        detailView?.frame = SCREENBounds
        containerView.addSubview(detailView!)
        detailView?.alpha = 0
        
        UIView.animate(withDuration: 3, animations: {
            animationView.frame = toFrame
            detailView?.alpha = 1
        }, completion: { (complete) in
            animationView.removeFromSuperview()
            //动画过程中不允许用户交互
            transitionContext.completeTransition(true)
        })
        
    }
    
    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning){
        
        guard let dD = dismissDelegate else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        //1.做动画的视图
        let animationView = dD.dismissAnimationView()
        //2.动画起始位置
        let fromFrame = dD.dismissAnimationFromFrame()
        //1.动画结束位置
        let toFrame = dD.dismissAnimationToFrame()
        
        containerView.addSubview(animationView)
        animationView.frame = fromFrame
        //目标控制器的视图，不会在自动添加到containerView里面去了
        let fromView = transitionContext.view(forKey: .from)
        
        UIView.animate(withDuration: 3, animations: {
            animationView.frame = toFrame
            fromView?.alpha = 0
        }, completion: { (complete) in
            animationView.removeFromSuperview()
            fromView?.removeFromSuperview()
            //动画过程中不允许用户交互
            transitionContext.completeTransition(true)
        })
        
    }

}



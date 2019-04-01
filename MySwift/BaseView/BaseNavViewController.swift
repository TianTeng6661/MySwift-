//
//  BaseNavViewController.swift
//  MySwift
//
//  Created by yinhe on 2019/3/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit

class BaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationBar.barTintColor = NAV_BACK_COLOR
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor:NAV_Title_COLOR,NSAttributedString.Key.font:SystemFont(font: 17)];
        self.navigationBar.titleTextAttributes = titleTextAttributes;
        
    }
    
    //获取当前控制器
    func getCurrentController()->UIViewController{
        
        let window = UIApplication.shared.keyWindow
        var result = window?.rootViewController
        if(result?.isKind(of: UITabBarController.classForCoder()))!{
            
            result = (result as!UITabBarController).selectedViewController
            
        }else if(result?.isKind(of: UINavigationController.classForCoder()))!{
            
            result = (result as! UINavigationController).visibleViewController
            
        }else if(result?.presentedViewController != nil){
            result = result?.presentedViewController
        }
        return result!;
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.viewControllers.count>0){
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: true)
    }

}

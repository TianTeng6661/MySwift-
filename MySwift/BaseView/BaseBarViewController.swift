//
//  BaseBarViewController.swift
//  MySwift
//
//  Created by yinhe on 2019/3/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit


class BaseBarViewController: UITabBarController {
    
    private let homeVC = HomeController();
    private let mailListVC = MailListController();
    private let FindVC = FindController();
    private let MyVC = MyController();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBar.isTranslucent = false
        
        setUpTabbar()
        
        addChildViewController(HomeController(), title: "首页", normalImage: "home_unSel", selectedImage: "home_Sel")
        addChildViewController(MailListController(), title: "通讯录", normalImage: "order_unSel", selectedImage: "order_Sel")
        addChildViewController(FindController(), title: "购物车", normalImage: "shop_unSel", selectedImage: "shop_Sel")
        addChildViewController(MyController(), title: "我", normalImage: "my_unSel", selectedImage: "my_Sel")

        /*
        viewControllers = [
            createController(title:"首页", imageName:"home_unSel", selectImage: "home_Sel", vc: HomeController()),
            createController(title:"通讯录", imageName:"order_unSel", selectImage: "order_Sel", vc: MailListController()),
            createController(title:"购物车", imageName:"shop_unSel", selectImage: "shop_Sel", vc: FindController()),
            createController(title:"我", imageName:"my_unSel", selectImage: "my_Sel", vc: MyController())];
        */
    }
    
    //自定义tabbar的样式
    
    fileprivate func setUpTabbar(){
        //tabbar顶部横线
        let rect = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.tabBar.shadowImage = image
        self.tabBar.backgroundImage = UIImage()
        //tabbar工具栏背景色
        self.tabBar.barTintColor = UIColor.white
        
        //设置为点击文字颜色
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : HEXCOLOR(0x333333)], for: UIControl.State.normal)
        //设置点击之后文字颜色
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : HEXCOLOR(0xf4b541)], for: UIControl.State.selected)
    }
    
    func addChildViewController(_ childController:UIViewController,title:String,normalImage:String,selectedImage:String){
        childController.title = title;
        
        //设置小圆图标
        //self.tabBarItem.badgeValue = "1";
        //self.tabBarItem.badgeColor = UIColor.yellow
        
        let image = UIImage(named: normalImage)
        let imageSel = UIImage(named: selectedImage)
        //设置原始图片
        childController.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal);
        childController.tabBarItem.selectedImage = imageSel?.withRenderingMode(.alwaysOriginal);
        let navi = BaseNavViewController()
        //let navi = BaseNavViewController.init(rootViewController: childController)
        navi.addChild(childController)
        addChild(navi)
    }
    
    /*
    private func createController(title:String,imageName:String,selectImage:String,vc:UIViewController)->UINavigationController{
        let recentVC = UINavigationController(rootViewController: vc)
        
        recentVC.tabBarItem.title = title;
        //设置小圆图标
        //recentVC.tabBarItem.badgeValue = "1";
        //recentVC.tabBarItem.badgeColor = UIColor.yellow
        //设置tabBar的背景颜色
        self.tabBar.backgroundColor = UIColor.white
        //移除顶部线条
        self.tabBar.shadowImage = UIImage()
        //设置为点击文字颜色
        recentVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : HEXCOLOR(0x333333)], for: UIControl.State.normal)
        //设置点击之后文字颜色
        recentVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : HEXCOLOR(0xf4b541)], for: UIControl.State.selected)
        let image = UIImage(named: imageName)
        let imageSel = UIImage(named: selectImage)
        //设置原始图片
        recentVC.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal);
        recentVC.tabBarItem.selectedImage = imageSel?.withRenderingMode(.alwaysOriginal);
        return recentVC;
    }
*/
}

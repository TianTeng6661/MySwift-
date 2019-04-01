//
//  GuidepagesViewController.swift
//  MySwift
//
//  Created by yinhe on 2019/3/29.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit

class GuidepagesViewController: UIViewController,UIScrollViewDelegate {

    var pageControl:UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initSubviews()
        
    }
    
    func initSubviews() {
        var myScrollView:UIScrollView
        myScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        myScrollView.bounces = false
        myScrollView.isPagingEnabled = true
        myScrollView.showsVerticalScrollIndicator = false
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.contentSize = CGSize(width: SCREENWIDTH*CGFloat(3), height: SCREENHEIGHT)
        myScrollView.delegate = self;
        view .addSubview(myScrollView)
        for index in 1...3{
            print(index)
            
            var imageView:UIImageView
            imageView = UIImageView.init(frame: CGRect(x: (SCREENWIDTH*CGFloat(index-1)), y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
            let imageStr:String = "Y_"
            let imageName:String = "\(imageStr)\(index)"
            imageView.image = (UIImage(named: imageName));
            imageView.backgroundColor = UIColor.white
            myScrollView .addSubview(imageView)
            //在最后一页添加按钮
            if(index==3){
                imageView.isUserInteractionEnabled = true
                let button:UIButton = UIButton(type: .custom)
                button.frame = CGRect(x: (SCREENWIDTH-185)/2, y: SCREENHEIGHT-180, width: 185, height: 50)
                button .setTitle("点击进入", for: .normal)
                button .setTitleColor(UIColor.white, for: .normal)
                button.layer.borderWidth = 2
                button.layer.cornerRadius = 5
                button.clipsToBounds = true
                button.layer.borderColor = UIColor.white.cgColor
                button .addTarget(self, action:#selector(go(buttonGo:)), for: .touchUpInside)
                imageView .addSubview(button)
            }
            
            pageControl = UIPageControl.init(frame: CGRect(x:SCREENWIDTH/CGFloat(3), y: SCREENHEIGHT*14/CGFloat(15), width: SCREENWIDTH/CGFloat(3), height: SCREENHEIGHT/CGFloat(16)))
            //设置页数
            pageControl.numberOfPages = 3
            //设置选中和未选中的图片
            pageControl.setValue(UIImage.init(named:"huahuitiao"), forKey: "_pageImage")//当前
            pageControl.setValue(UIImage.init(named:"hualantiao"), forKey: "_currentPageImage") //选中
            
            /*
             // 设置页码的点的颜色
             pageControl.pageIndicatorTintColor = [UIColor yellowColor];
             // 设置当前页码的点颜色
             pageControl.currentPageIndicatorTintColor = [UIColor redColor];
             */
            view .addSubview(pageControl)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //计算当前在第几页
        pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x/SCREENWIDTH)
    }
    
    @objc func go(buttonGo:UIButton){
        
        let version:String = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as?String)!
        UserDefaults.standard.setValue(version, forKey: "notFirst")
        UserDefaults.standard.synchronize()
        
        let ap:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tabbar = BaseBarViewController()
        ap.window?.rootViewController = tabbar;
        
    }

}

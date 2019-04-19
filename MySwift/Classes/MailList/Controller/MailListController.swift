//
//  MailListController.swift
//  MySwift
//
//  Created by yinhe on 2019/3/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import WebKit
import WebViewJavascriptBridge

class MailListController: BaseViewController {

    var webBridge:WKWebViewJavascriptBridge!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .blue
        self.setStatusBarBackgroundColor(color: NAV_BACK_COLOR)
        
        self.view .addSubview(self.webView)
        
        self.webBridge = WKWebViewJavascriptBridge.init(for: self.webView)
        self.webBridge.setWebViewDelegate(self)
        
        //注册引用方法
        registFunction()
        
        
    }
    //Mark --修改状态栏颜色
    func setStatusBarBackgroundColor(color : UIColor) {
        
        let barView = UIView.init(frame: CGRect(x: 0, y: 0, width: Int(SCREENWIDTH), height: STatusHeight))
        barView.backgroundColor = color
        view.addSubview(barView)
    }
    func registFunction(){
        self.webBridge.registerHandler("mapLocation") { (data, callBack) in
            
            let param:[String:Any] = data as! Dictionary
            print(param)
        }
    }
    
    lazy var webView:WKWebView = {
        //创建wkwebView
        let webView = WKWebView(frame: CGRect(x: 0, y: CGFloat(STatusHeight), width: SCREENWIDTH, height: SCREENHEIGHT-CGFloat(TabbarHeight)-CGFloat(STatusHeight)))
        //创建网址
        let url = NSURL(string: "https://www.baidu.com")
        //创建请求
        let request = NSURLRequest(url: url! as URL)
        //加载请求
        webView.load(request as URLRequest)
        return webView
    }()

}

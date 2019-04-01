//
//  HomeController.swift
//  MySwift
//
//  Created by yinhe on 2019/3/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit

class HomeController: BaseViewController {

    var exampleLab:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = VIEW_BACK_COLOR;
        
        title = "第一个";
        
        //初始化lab
        self.exampleLab = UILabel.init()
        self.exampleLab.frame = CGRect.init(x: 0, y: 100, width: SCREENWIDTH, height: 30)
        self.exampleLab.textAlignment = .center;
        self.exampleLab.text = "哈哈哈哈啊哈哈"
        self.exampleLab.backgroundColor = UIColor.orange
        self.exampleLab.font = SystemFont(font: 13);
        self.exampleLab.textColor = HEXCOLOR(0x003bff)
        self.view .addSubview(self.exampleLab)
    
    }
    

}

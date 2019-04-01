//
//  PrefixFile.swift
//  MySwift
//
//  Created by yinhe on 2019/3/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import Foundation

/*
 公共的头文件
 */
import UIKit


/*
 公共的宏定义
 */
let SCREENWIDTH = UIScreen.main.bounds.size.width
let SCREENHEIGHT = UIScreen.main.bounds.size.height
//屏幕比例
let kHCWLScale = (SCREENHEIGHT/667.0)
let kWCWLScale = (SCREENWIDTH/375.0)
//iPhoneX的适配
let Is_Iphone = (UI_USER_INTERFACE_IDIOM()==UIDevice.current.userInterfaceIdiom)
let Is_Iphone_X = (Is_Iphone&&(SCREENHEIGHT>=812))
let NaviHeight = Is_Iphone_X ? 88:64
let TabbarHeight = Is_Iphone_X ? 83:49
let BottomHeight = Is_Iphone_X ? 34:0
let STatusHeight = Is_Iphone_X ? 44:20

 func x(object:UIView)->CGFloat{
    return object.frame.origin.x;
}
//颜色
func HEXCOLOR(_ colorRgb: UInt32) -> UIColor {
    return UIColor.init(red: CGFloat((colorRgb & 0xFF0000) >> 16) / 255, green: CGFloat((colorRgb & 0x00FF00) >> 8) / 255, blue: CGFloat(colorRgb & 0x0000FF) / 255, alpha: 1)
}

let NAV_BACK_COLOR = HEXCOLOR(0xf4b541)
let NAV_Title_COLOR = HEXCOLOR(0xffffff)
let VIEW_BACK_COLOR = HEXCOLOR(0xe5e5e5)

func SystemFont(font:CGFloat)->UIFont{
   return UIFont.boldSystemFont(ofSize: font)
}

//图片设置名称
func imageNamed(_ name: String) -> UIImage? {
    return UIImage(named: name)
}





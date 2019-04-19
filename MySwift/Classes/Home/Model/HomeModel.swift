//
//  HomeModel.swift
//  MySwift
//
//  Created by yinhe on 2019/4/1.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import HandyJSON

class HomeModel: HandyJSON {
    
    var id:String?
    var title:String?
    var year:String?
    var original_title:String?
    var images:Dictionary<String, Any>?
    var genres:Array<Any>?
    
    
    
    //var casts = [NSArray]()
    
    required init(){}

}

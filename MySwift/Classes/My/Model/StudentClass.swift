//
//  StudentClass.swift
//  MySwift
//
//  Created by yinhe on 2019/4/11.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit

@objcMembers //kvc必须添加
class StudentClass: NSObject {

    //kvc的时候必须是有默认孩子，不能对泛型进行赋值
    /*
     var name:String？
     var age:Int？
     var score:Double？
    
    init(dic:[String:Any]){
        let name = dic["name"] as? String ?? ""
        let age = dic["age"] as? Int ?? 0
        let score = dic["score"] as? Double ?? 0.0
        self.name = name
        self.age = age
        self.score = score
    }
    */
    var name:String = ""
    var age:Int = 0
    var score:Double = 0.0
    init(dic:[String:Any]){
        /*
        let name = dic["name"] as? String ?? ""
        let age = dic["age"] as? Int ?? 0
        let score = dic["score"] as? Double ?? 0.0
        self.name = name
        self.age = age
        self.score = score
        */
        super.init()
        setValuesForKeys(dic)
        
        
    }
    
    
}

//
//  MyController.swift
//  MySwift
//
//  Created by yinhe on 2019/3/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit



enum FileError:Error{
    case notExists
    case notFormat
    case noContent
}

class MyController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.lightGray
        
        
        let person = Person()
        person .test()
        Person .play()

        /*
        let dataDic:[String:Any] = ["name":"王婷","age":13,"score":3.7];
        
        let student = StudentClass(dic: dataDic)
        print(student.name ?? "")
        print(student.age ?? 0)
        print(student.score ?? 0.0)
        */
        
        let path = "wwwwwwwww"
        //第一种处理异常方式
        do{
            let content = try readFile(path: path)
            print(content)
        }catch{
            print(error)
        }
        
        //第二种处理异常方式，有异常但是不处理，如果有问题就是nil
        let content2: String? = try? readFile(path: path)
        
        //第三种处理异常方式
        
    }
    
    // MARK: -- 读取文件内容并容错处理
    func readFile(path:String) throws -> String{
        //1.判断文件路径是否存在
        let isExsits = FileManager.default.fileExists(atPath: path)
        if (!isExsits){ //在这里抛出出现的问题
            throw FileError.notExists
        }
        //2.读取文件内容
        var content:String = ""
        do{
            content = try String(contentsOfFile: path)
        }catch{
            throw FileError.notFormat
        }
        if content.lengthOfBytes(using: String.Encoding.utf8) == 0 {
            throw FileError.noContent
        }
        
        return content
    }

}

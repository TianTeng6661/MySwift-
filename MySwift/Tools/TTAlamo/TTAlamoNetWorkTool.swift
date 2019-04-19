//
//  TTAlamoNetWorkTool.swift
//  MySwift
//
//  Created by yinhe on 2019/4/2.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import Alamofire

class TTAlamoNetWorkTool: NSObject{
    
    struct responseData {
        var request:URLRequest?
        var response:HTTPURLResponse?
        var json:AnyObject?
        var error:NSError?
        var data:Data?
    }
    
    class func requestWith(Method method:Alamofire.HTTPMethod, URL url:String, Parameter para:[String:Any]?,Token token:String?, handler:@escaping(responseData) ->Void){
        //网络判断
        let reachAble = judgeNetWork()
        print(reachAble)
        
        if(reachAble){ //有网
            
            var dicToken:[String:String]!
            if (token != nil){
                dicToken = ["token":token!]
            }
            //response
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 10
            manager.request(url, method: method, parameters: para, encoding: URLEncoding.default, headers: dicToken).response(completionHandler:{
                (response) in
                //DataResponse
                //print(res)
                //print(response.data)
                //print(response.result)
                
                let json:AnyObject! = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as AnyObject
                if (nil != json){
                    let res = responseData(request: response.request, response: response.response, json: json, error: response.error as NSError?, data: response.data)
                    handler(res)
                }
                
            })
            
        }
        
    }
    
    class func judgeNetWork()->Bool{
        var reach = true
        let manager = NetworkReachabilityManager(host :"www.baidu.com")
        manager?.listener = { status in
            
            switch status {
            case .notReachable:
                reach = false
            //没网络
            case .reachable(.ethernetOrWiFi):
                reach = true
            case .reachable(.wwan):
                reach = true
            case .unknown:
                reach = false
                //没网络
            }
            
        }
        manager?.startListening()
        return reach
    }
    
    
}




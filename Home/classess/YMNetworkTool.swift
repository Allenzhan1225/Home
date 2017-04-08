//
//  YMNetworkTool.swift
//  Home
//
//  Created by YDWY on 2017/4/7.
//  Copyright © 2017年 YDWY. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case get
    case post
}


class YMNetworkTool: NSObject {

}


extension YMNetworkTool{
    class func requestData(type:MethodType,urlString:String,parameters:[String:Any]? = nil,finishedCallBack: @escaping(_ result : Any,_ isSuccess:Bool) ->())  {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (responseData) in
            
            guard let result = responseData.result.value else {
                print(responseData.result.error ?? "")
                finishedCallBack(responseData,false)
                return
            }
            
            finishedCallBack(result,true)
            
        }
    }
}

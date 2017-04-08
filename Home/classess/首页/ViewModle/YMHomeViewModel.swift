//
//  YMHomeViewModel.swift
//  Home
//
//  Created by YDWY on 2017/4/7.
//  Copyright © 2017年 YDWY. All rights reserved.
//

import UIKit

import SwiftyJSON

class YMHomeViewModel: NSObject {

    lazy var anchors :[HomeModel]  = [HomeModel]()
    
}

extension YMHomeViewModel{
    func loadData ( finishedCallBack : @escaping() -> ())  {
        
        YMNetworkTool.requestData(type: .get, urlString: "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1" ) { (result, isSuccess) in
            let json = JSON(result)
            let dataArray = json["lives"]
            
            for dict in dataArray {
                if let dict  =  dict.1.dictionaryObject{
                    let model = HomeModel(dict: dict)
                    self.anchors.append(model)
                }
            }
            finishedCallBack()
            
        }
        
    }
}


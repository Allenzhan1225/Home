
//
//  YMLiveViewViewController.swift
//  Home
//
//  Created by YDWY on 2017/4/7.
//  Copyright © 2017年 YDWY. All rights reserved.
//

import UIKit
import IJKMediaFramework


class YMLiveViewViewController: UIViewController {
    
    var webView:UIWebView?
    var anchorModel : HomeModel!
    var ijkLivePlay : IJKFFMoviePlayerController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
        
        //你好
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



//MARK - 初始化界面
extension YMLiveViewViewController{
    fileprivate func setupUI(){
        
//        webView = UIWebView(frame: self.view.bounds)
//        view.addSubview(webView!)
//        
//  
//        guard let requestUrl =  URL(string: self.anchorModel.share_addr ?? "")  else { return  }
//        
//        print(requestUrl)
//        
//        webView?.loadRequest(URLRequest(url: requestUrl))
        
        view.backgroundColor = UIColor.clear
        let requsetUrl = URL(string: self.anchorModel.stream_addr ?? "")
        print(requsetUrl!)
        //00 设置不报告日志
//        IJKFFMoviePlayerController.setLogReport(false)
//        IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_INFO)
        
        //01 默认选项配置
        let  options  =  IJKFFOptions.byDefault()

        //0. 创建播放控制器
        ijkLivePlay = IJKFFMoviePlayerController(contentURL: requsetUrl, with: options)
        
        //1.设置播放器布满整个屏幕
        ijkLivePlay.view.frame = view.bounds
        
        //2.设置适配横竖屏幕（设置四边固定，长度灵活）
        ijkLivePlay.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        //3. 设置播放器视图的缩放模式
        ijkLivePlay.scalingMode = .aspectFill

        //4. 设置自动播放
        ijkLivePlay.shouldAutoplay = true

        //5. 自动更新子视图的大小
        view.autoresizesSubviews = true

        view.addSubview(self.ijkLivePlay.view)
    
        
    }
}



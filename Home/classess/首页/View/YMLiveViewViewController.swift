
//
//  YMLiveViewViewController.swift
//  Home
//
//  Created by YDWY on 2017/4/7.
//  Copyright © 2017年 YDWY. All rights reserved.
//

import UIKit



class YMLiveViewViewController: UIViewController {
    
    var webView:UIWebView?
     var anchorModel : HomeModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
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
        
        webView = UIWebView(frame: self.view.bounds)
        view.addSubview(webView!)
        
  
        guard let requestUrl =  URL(string: self.anchorModel.share_addr ?? "")  else { return  }
        
        print(requestUrl)
        
        webView?.loadRequest(URLRequest(url: requestUrl))
    }
}



//
//  YMTabBarVC.swift
//  Home
//
//  Created by YDWY on 2017/3/28.
//  Copyright © 2017年 YDWY. All rights reserved.
//

import UIKit

class YMTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置子控制器
        setupChildControllers()
        setupComposeButton()
        
        
    }

    /// 撰写微博
    public func composeStatus() {
        print("撰写微博")
        
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: - 私有控件
    //UIButton = UIButton.cz_imageButton( "tabbar_compose_icon_add",backgroundImageName: "tabbar_compose_button")
    // 编辑按钮
    public lazy var composeButton:UIButton = UIButton.cz_imageButton("", backgroundImageName: "tabbar_compose_camera")
}



//MARK: -设置界面
extension YMTabBarVC {
    
    //设置所有自控制器
    public func setupChildControllers(){
    
        //0.获取沙盒 josn 路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        //加载 Data
        var data = NSData(contentsOfFile:jsonPath)
        //判断 data 是否有内容 如果没有，说明本地沙盒没有文件
        if data == nil{
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
           
            data = NSData(contentsOfFile: path!)
        }
        
        //data 一定会有一个内容 ，反序列化
        // 反序列化成数组

        guard let array = try? JSONSerialization.jsonObject(with: data! as Data,
            options: []) as? [[String:AnyObject]] else{
            return
        }
        
        //遍历数组，循环创建控制器数组
        var arrayM = [UIViewController]()
        for dict in array! {
            
            arrayM.append(controller(dict: dict))
        }
        
        //设置 TabBar 的自控制器
        viewControllers = arrayM
        
    }
    
    
    
    /// 使用字典创建一个子控制器
    ///
    /// - Parameter dict: 信息字典[clsName ,title,imageName,visitorInfo]
    /// - Returns: 子控制器
    private func controller(dict:[String: AnyObject]) -> UIViewController{
    
        //1. 获取字典内容
        guard let clsName = dict["clsName"] as? String,
              let title = dict["title"] as? String,
              let imageName = dict["imageName"] as? String,
              let cls = NSClassFromString((Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "")+"."+clsName) as? UIViewController.Type
        
        
            else {
                return UIViewController()
        }
        
        //2. 创建视图控制器
        let vc = cls.init()
        
        vc.title = title
        
   
        //3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_"+imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_"+imageName+"_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 4. 设置 tabbar 的标题字体（大小）
        vc.tabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.orange],
            for: .highlighted)
        // 系统默认是 12 号字，修改字体大小，要设置 Normal 的字体大小
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: .normal)
        
        
        //实例化导航栏控制器的时候，会调用 push 方法将 rootVC 压栈
        let nav = YMNavController(rootViewController: vc)
        return nav;
    }
    
    
    public func setupComposeButton(){
        tabBar.addSubview(composeButton)
        
        //计算按钮宽度
        let count  = CGFloat(childViewControllers.count)
        //将向内缩进的宽度
        let width = (tabBar.bounds.width - 1) / count
        // CGRectInset 正数向内缩进，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: width * 2, dy: -10)
        
        // 按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    
    
    
    
    
}











//
//  YMBaseViewController.swift
//  Home
//
//  Created by YDWY on 2017/3/29.
//  Copyright © 2017年 YDWY. All rights reserved.
//

import UIKit

class YMBaseViewController: UIViewController {

    
    ///表格视图 - 
    var tableView: UITableView?
    
    //刷新控件
    var refreshControll: UIRefreshControl?
    
    
    //懒加载
    lazy var dataSource: NSMutableArray = NSMutableArray()

    
    
    
    // 上拉刷新标志
    var isPullUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }


    //加载数据 - 具体的实现由子类负责
    func loadData() {
         refreshControll?.beginRefreshing()
        //下拉刷新
        if !isPullUp {
            
            print("下拉刷新")
            dataSource.removeAllObjects()
            
            
            //模拟异步
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 3), execute: {
                for i in 0...10 {
                    self.dataSource.add(String(i))
                }
                DispatchQueue.main.async {
                    self.isPullUp = false
                    self.refreshControll?.endRefreshing()
                    self.tableView?.reloadData()
                    
                }
            })
            
           
        }else{//上拉加载
             print("上拉加载")
            DispatchQueue.global().asyncAfter(deadline: .init(uptimeNanoseconds: 3), execute: {
                for i in 0...10 {
                    self.dataSource.add(String(i))
                }
                DispatchQueue.main.async {
                    self.isPullUp = false
                    self.refreshControll?.endRefreshing()
                    self.tableView?.reloadData()
                }
            })
            
           
        }
        
        
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



//MARK:-  设置界面
extension YMBaseViewController{
    
    
    public func setupUI(){
        view.backgroundColor = UIColor.white
        
        //取消自动缩进 - 如果隐藏了导航栏 ，会缩进20 个点
        automaticallyAdjustsScrollViewInsets = false
        
        setupTableView()
        
    }
    

    
    func  setupTableView(){
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        
        //设置数据源& 代理 -> 目的：子类直接实现数据源方法
        tableView?.dataSource = self;
        tableView?.delegate = self;
        
        tableView?.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        
        // 修改指示器的缩进 - 强行解包是为了拿到一个必有的 inset
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
        //设置刷新控件
        refreshControll = UIRefreshControl()
        tableView?.addSubview(refreshControll!)
        refreshControll?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        view.addSubview(tableView!)
    }
    

   
    
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension YMBaseViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // 基类只是准备方法，子类负责具体的实现
    // 子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //只是保证没有语法错误
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        let num = dataSource[indexPath.row] as? String
        cell?.textLabel?.text = "第"+num!+"行"
        
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    ///在显示最后一行的时候。做上拉加载
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //1. 判断 indexPath 是否是最后一行
        // （indexPath.section(最大) / （indexPath.row）最后一行）
        
        //2、row /section
        let row = indexPath.row
        let section = indexPath.section
        
        if row < 0 || section < 0 {
            return
        }
        
        //获取当前section 下的行数
        let count = tableView.numberOfRows(inSection: section)
        
        //如果是最后一行同时没有下拉刷新的话 ，就是上拉加载
        if row == count - 1 && !isPullUp {
          
            isPullUp = true
            
            //开始刷新
            loadData()
            
        }
        
        
        
    }
    
}


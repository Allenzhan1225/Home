//
//  YMHomeViewController.swift
//  Home
//
//  Created by YDWY on 2017/3/29.
//  Copyright © 2017年 YDWY. All rights reserved.
//

import UIKit
import MJRefresh
private let kCellID = "YMLiveListCell"



class YMHomeViewController: YMBaseViewController {

    
    fileprivate lazy var homeVM : YMHomeViewModel = YMHomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI1()
        refreshData()

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
/// Editor placeholder in source file

extension YMHomeViewController{
    fileprivate func setupUI1() {
        navigationItem.title = "直播列表"
        tableView?.register(UINib(nibName:"YMLiveListCell" ,bundle:nil), forCellReuseIdentifier: kCellID)
    }
}


extension YMHomeViewController{
    
    fileprivate func refreshData(){
        tableView?.mj_header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction:#selector(loadHomeData) )
        tableView?.mj_header.beginRefreshing()
    }
    
    @objc fileprivate func loadHomeData(){
        self.homeVM.loadData {
            self.tableView?.mj_header.endRefreshing()
            self.tableView?.reloadData()
        }
    }
    
    
}






//MARK - tableView 代理方法
extension YMHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeVM.anchors.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellID, for: indexPath) as! YMLiveListCell
        cell.anchorModel = homeVM.anchors[indexPath.section]
        return cell

    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81 + UIScreen.main.bounds.width
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = homeVM.anchors[indexPath.section]
        DispatchQueue.main.async {
            let vc = YMLiveViewViewController()
            vc.anchorModel = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.removeAllAnimations()
        cell.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1)
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }) { (_) in
            let  anim = CATransition()
            anim.type = "rippleEffect"
            anim.duration = 1
            cell.layer.add(anim, forKey: "11111")
        }
    }
    
}

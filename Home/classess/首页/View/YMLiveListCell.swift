//
//  YMLiveListCell.swift
//  Home
//
//  Created by YDWY on 2017/4/6.
//  Copyright © 2017年 YDWY. All rights reserved.
//

import UIKit

import Kingfisher

class YMLiveListCell: UITableViewCell {

    ///Cannot load underlying module for 'Kingfisher'
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var avator: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lableNums: UILabel!
    @IBOutlet weak var cityLb: UILabel!
    
    var anchorModel : HomeModel?{
        didSet {
            guard let anchorModel = anchorModel else {
                return
            }
            
            lableNums.text = "\(anchorModel.online_users)人在看"
            cityLb.text = anchorModel.city
            name.text = anchorModel.userInfo?.nick
            var imageUrl = anchorModel.userInfo?.portrait
            if imageUrl?.hasPrefix("http://img2.inke.cn/") == false {
                imageUrl = "http://img2.inke.cn/" + (anchorModel.userInfo?.portrait)!
            }
            
            imageV.layer.cornerRadius = 32.5
            imageV.layer.masksToBounds = true
            imageV.layer.shouldRasterize = true
            
            
            
            
            
            if let url = URL(string: imageUrl ?? "") {
             
                
                avator.kf.setImage(with: url, placeholder: UIImage(named: "avatar_default"))
                imageV.kf.setImage(with: url, placeholder: UIImage(named: "avatar_default"))

            }else {
                avator.image = UIImage(named: "avatar_default")
                imageV.image = UIImage(named: "avatar_default")
            }
        }

    }
    

    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

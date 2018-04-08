//
//  ZWTableViewCell.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import Reusable
class ZWTableViewCell: UITableViewCell ,NibReusable{

    @IBOutlet weak var imgV: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var describeLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  ZWDynamicTableViewCell.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import Reusable
class ZWDynamicTableViewCell: UITableViewCell,Reusable {

    var imgView: UIImageView?
    var titleLab:UILabel?
    var despLab:UILabel?
    var timeLab:UILabel?
    var photoBrowser:ZWPhotoBrowser?
    
    
    var model = ZWModel(){
        didSet{
            
            imgView?.kf.setImage(with: URL(string: "http://iyouwen-1.oss-cn-shanghai.aliyuncs.com/\(model.senderpic)"))
            titleLab?.text = model.sendername
            despLab?.text = model.content.removingPercentEncoding
            timeLab?.text = model.sendtime
            photoBrowser?.createBtn(btnDataSource: model.imgArrs)
            photoBrowser?.snp.updateConstraints({ (make) in
                make.size.equalTo(model.imgVSize)
            })
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    func setupUI() {

        imgView = UIImageView().then({
            
            $0.image = UIImage.init(named: "img.jpg")
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 1.0
            self.contentView.addSubview($0)
        })

        titleLab = UILabel().then ({
            
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .red
            self.contentView.addSubview($0)
        })
  
         despLab = UILabel().then {
            
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .black
            $0.numberOfLines = 0
            self.contentView.addSubview($0)
        }
    
        timeLab = UILabel().then({
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = UIColor(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1)
            self.contentView.addSubview($0)
        })
        
        photoBrowser = ZWPhotoBrowser()
        
        self.contentView.addSubview(photoBrowser!)

        imgView?.snp.makeConstraints({ (make) in
            make.top.left.equalTo(12)
            make.width.height.equalTo(41)
        })
        
        titleLab?.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo((imgView?.snp.right)!).offset(11.5)
            make.right.equalTo(-10)
            make.height.equalTo(21)
        }
        
        timeLab?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-10)
            make.left.equalTo((imgView?.snp.right)!).offset(11.5)
            make.height.equalTo(20)
            make.right.equalTo(-10)
        })
        
        photoBrowser?.snp.makeConstraints({ (make) in
            make.left.equalTo((imgView?.snp.right)!).offset(11.5)
            make.bottom.equalTo((timeLab?.snp.top)!).offset(-5)
            make.size.equalTo(model.imgVSize)
        })
        despLab?.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab!.snp.bottom).offset(10)
            make.left.equalTo((imgView?.snp.right)!).offset(11.5)
            make.right.equalTo(-10)
            make.bottom.equalTo(photoBrowser!.snp.top).offset(-10)
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

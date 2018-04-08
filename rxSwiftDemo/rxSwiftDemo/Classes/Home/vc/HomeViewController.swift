//
//  HomeViewController.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/4/3.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import NSObject_Rx
import RxDataSources
import Kingfisher
import Reusable
import Alamofire
class HomeViewController: UIViewController {

    let tableView = UITableView().then {
        $0.backgroundColor = UIColor.red
        $0.rowHeight = 240
        $0.register(cellType: ZWTableViewCell.self)
    }
    let dataSource = RxTableViewSectionedReloadDataSource<ZWSection>(configureCell: {
        ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(for: ip) as ZWTableViewCell

        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "tableView"
        print(  UserDefaults.standard.value(forKey: "token"))
        zwWeitoutiaoTool.rx.request(.weitoutiao).asObservable().mapArray(ZWModel.self).subscribe(onNext: {
            
            print($0)
        }).disposed(by: rx.disposeBag)


    }
    
    
}
extension HomeViewController {
    
    fileprivate func setupUI() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).offset(64);
        }
        
        // 设置代理
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
    }
}
  
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



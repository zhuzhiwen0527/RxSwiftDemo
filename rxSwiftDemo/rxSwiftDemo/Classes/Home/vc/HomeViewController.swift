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
import MJRefresh
class HomeViewController: UIViewController {
    
    let viewModel = ZWDynamicViewModel()
    let tableView = UITableView().then {
        $0.rowHeight = UITableViewAutomaticDimension
        $0.register(cellType: ZWDynamicTableViewCell.self)
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<ZWSection>(configureCell: {
        ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(for: ip) as ZWDynamicTableViewCell
        cell.model = item
        return cell
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "tableView"
        setupUI()
        bindView()
    }
    
    
}
extension HomeViewController {
    
    fileprivate func setupUI() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).offset(64);
        }
        

    }
    
    fileprivate func bindView(){
        // 设置代理
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
  
        
        
        let vmInput = ZWDynamicViewModel.ZWInput()
        let vmOutput = viewModel.transform(input: vmInput)
        
        vmOutput.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        vmOutput.requestCommond.onNext(true)
        vmOutput.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header.endRefreshing()
            case .beingFooterRefresh:
                self?.tableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.tableView.mj_footer.endRefreshing()
            case .noMoreData:
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: rx.disposeBag)

        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            vmOutput.requestCommond.onNext(true)
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            vmOutput.requestCommond.onNext(false)
        })

       
    }
}
  
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let models =  self.viewModel.models.value
        let m = models[indexPath.row]
        return m.cellH
    }
}



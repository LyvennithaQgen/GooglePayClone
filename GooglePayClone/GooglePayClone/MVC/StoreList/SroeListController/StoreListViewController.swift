//
//  StoreListViewController.swift
//  GooglePayClone
//
//  Created by Lyvennitha on 30/12/21.
//

import Foundation
import UIKit

class StoreListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    typealias StoreDataSource = UITableViewDiffableDataSource<Int, StoreListResponse>
    typealias SnapShotSource = NSDiffableDataSourceSnapshot<Int, StoreListResponse>
    
    var storeDataSource: StoreDataSource!
    var snapShotSource: SnapShotSource!
    
    var storeListData: [StoreListResponse]?
    
    var kTableHeaderHeight:CGFloat = 200.0
    var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView()
        self.getStoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func configureTable(){
        storeDataSource = StoreDataSource(tableView: self.tableView, cellProvider: {(tbl, indexPath, data) -> UITableViewCell in
            let cell = tbl.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? StoreListCell
            cell?.nameLbl.text = self.storeListData?[indexPath.row].name
            cell?.indexPath = indexPath.row
            cell?.phnoLbl.text = self.storeListData?[indexPath.row].contact
            cell?.profile.backgroundColor = .green
            cell?.profile.layer.cornerRadius = 35
            cell?.profile.downloaded(from: self.storeListData?[indexPath.row].logo ?? "", contentMode: .scaleAspectFill)
            return cell!
            
        })
    }
    
    func updateTable(){
        var snapShot = SnapShotSource()
        snapShot.appendSections([0])
        snapShot.appendItems(storeListData!)
        storeDataSource.apply(snapShot)
    }
    
    func updateHeaderView() {
        
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }
    
}

extension StoreListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "PaymentViewController") as? PaymentViewController
        vc?.imgURL = self.storeListData?[indexPath.row].logo ?? ""
        vc?.name = self.storeListData?[indexPath.row].name ?? ""
        vc?.phno = "Sending money to\(self.storeListData?[indexPath.row].contact ?? "")"
        vc?.title = "Paying to \(self.storeListData?[indexPath.row].name ?? "")"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}

extension StoreListViewController{
    
    func getStoreData(){
        StoreListModel.getStoreList(action: .storeList, onResponse: {(result) in
            switch result{
            case .success(let data):
                self.storeListData = data
                DispatchQueue.main.async {
                    self.updateTable()
                }
                print(data.count)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}


class StoreListCell: UITableViewCell{
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phnoLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    var indexPath = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if indexPath == 0{
            self.mainView.layer.masksToBounds = false
            self.mainView.addShadow(shadowColor: .gray, offSet: CGSize(width: 2.6, height: 2.6), opacity: 1.0, shadowRadius: 5.0, cornerRadius: 15, corners: [.topLeft, .topRight])
        }else{
            self.mainView.layer.masksToBounds = true
        }
    }
    
}

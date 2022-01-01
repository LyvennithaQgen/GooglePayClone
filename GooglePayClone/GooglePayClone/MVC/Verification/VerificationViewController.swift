//
//  VerificationViewController.swift
//  GooglePayClone
//
//  Created by Lyvennitha on 28/12/21.
//

import Foundation
import UIKit
import SwiftyGif

typealias BankListDataSource = UITableViewDiffableDataSource<Int, String>
typealias BankListSnapShot = NSDiffableDataSourceSnapshot<Int, String>

class VerificationViewController: UIViewController{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var bottomPopUp: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueBtn: UIButton!
    
    static var delegate: VerificationViewController?
    
    var enableBack: Bool = false
    var bankDataSource: BankListDataSource!
    var bankListSnapShot: BankListSnapShot!
    var bnkName = ""
    var bnkImg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gif = try? UIImage(gifName: "Line.gif")
        self.image.setGifImage(gif!, loopCount: 1)
        configureTable()
        updateDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        VerificationViewController.delegate = self
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bottomPopUp.addShadow(shadowColor: .gray, offSet: CGSize(width: 2.6, height: 2.6), opacity: 1.0, shadowRadius: 5.0, cornerRadius: 12, corners: [.topLeft, .topRight])
    }
    
    func setupUI(){
        self.continueBtn.isHidden = true
        bottomPopUp.isHidden = true
        if enableBack == true{
            self.navigationItem.setHidesBackButton(true, animated: true)
            updateDataSource()
            self.continueBtn.isHidden = false
            bottomPopUp.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()+5, execute: { [self] in
                bottomPopUp.isHidden = true
                self.tableView.reloadData()
                self.navigationItem.setHidesBackButton(true, animated: true)
                UserDefaults.standard.setValue(true, forKey: "LoggedIn")
            })
        }else{
            self.showAlert(message: "Add bank Account to make transcactions", title: "Add Bank Account", needCancel: false)
        }
    }
}

extension VerificationViewController{
    func configureTable(){
        bankDataSource = BankListDataSource(tableView: self.tableView, cellProvider: { [self](tblView, indexpath, data) -> UITableViewCell in
            if enableBack {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Account", for: indexpath)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexpath)
            return cell
        })
    }
    
    func updateDataSource(){
        var snapshot = BankListSnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(["a"])
        bankDataSource.apply(snapshot)
    }
}

extension VerificationViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !enableBack {
            let vc = (storyboard?.instantiateViewController(withIdentifier: "BankSelectionViewController") as? BankSelectionViewController)!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//
//  PaymentViewController.swift
//  GooglePayClone
//
//  Created by Lyvennitha on 31/12/21.
//

import Foundation
import UIKit

class PaymentViewController: UIViewController{
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phnoLbl: UILabel!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var addNoteField: UITextField!
    
    var imgURL: String?
    var name: String?
    var phno: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(donePay), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.profileImg.downloaded(from: self.imgURL ?? "", contentMode: .scaleAspectFill)
        self.nameLbl.text = name
        self.phnoLbl.text = phno
        amount.becomeFirstResponder()
    }
    
    @objc func donePay(){
        if amount.text != "0" && amount.text != ""{
        let vc = storyboard?.instantiateViewController(identifier: "PaymentSuccessViewController") as? PaymentSuccessViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}

//
//  PaymentSuccessViewController.swift
//  GooglePayClone
//
//  Created by Lyvennitha on 31/12/21.
//

import Foundation
import UIKit

class PaymentSuccessViewController: UIViewController{
    @IBOutlet weak var successGif: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        let gif = try? UIImage(gifName: "success.gif")
        self.successGif.setGifImage(gif!, loopCount: 1)
    }
    
    @IBAction func doneAction(_ sender: UIButton){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: StoreListViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}

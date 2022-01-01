//
//  BankSelectionViewController.swift
//  GooglePayClone
//
//  Created by Lyvennitha on 29/12/21.
//

import Foundation
import UIKit

class BankSelectionViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageList = ["Axis", "Indian_Bank", "Federal"]
    var bankList = ["Axis Bank", "Indian Bank", "Fedaral Bank"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        VerificationViewController.delegate?.enableBack = true
    }
    
}

extension BankSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BankSelectionCell
        cell?.bankImg.image = UIImage(named: imageList[indexPath.row])
        cell?.bankName.text = bankList[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width/3-30, height: size.width/3+50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        VerificationViewController.delegate?.enableBack = true
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


class BankSelectionCell: UICollectionViewCell{
    @IBOutlet weak var bankImg: UIImageView!
    @IBOutlet weak var bankName: UILabel!
}

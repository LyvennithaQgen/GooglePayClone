//
//  StoreListModel.swift
//  GooglePayClone
//
//  Created by Lyvennitha on 30/12/21.
//

import Foundation

class StoreListModel{
    
    class func getStoreList(action:PaymentActions, onResponse: @escaping (Result<[StoreListResponse], Error>) -> ()){
        NetworkLayer.getStoreList(action: action, onResponse: onResponse)
    }
}



// MARK: - StoreListResponseElement
public struct StoreListResponse: Codable, Hashable {
    public var id: Int?
    public var name: String?
    public var logo: String?
    public var contact: String?

    public init(id: Int?, name: String?, logo: String?, contact: String?) {
        self.id = id
        self.name = name
        self.logo = logo
        self.contact = contact
    }
}

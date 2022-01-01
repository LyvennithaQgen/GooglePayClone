//
//  NetworkLayer.swift
//  GooglePayClone
//
//  Created by Lyvennitha on 30/12/21.
//

import Foundation

class NetworkLayer{
    
    class func getStoreList<T: Codable>(action: PaymentActions, onResponse: @escaping (Result<T, Error>) -> ()){
        var request = URLRequest.init(url: URL(string: action.rawValue)!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request){(data, response, error) in
            guard let jsonData = data else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
                print(json)
            } catch {
                print("issue in json data")
            }
            let decoder = JSONDecoder()
            if let response = try? decoder.decode(T.self, from: jsonData) {
                onResponse(.success(response))
            } else {
                onResponse(.failure(error!))
            }
        }.resume()
    }
}


enum PaymentActions: String{
    case storeList = "https://run.mocky.io/v3/f082d1e7-362c-4073-a3c2-ec33851224e9"
    case paymentInit = "https://run.mocky.io/v3/6cdc43f3-fc7f-4db0-9d0d-51d9ceae2bb8"
}

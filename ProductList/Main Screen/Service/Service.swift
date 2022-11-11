//
//  Service.swift
//  ProductList
//
//  Created by darkhan on 11.11.2022.
//

import Foundation
import Alamofire

final class Service {
    static let sharedInstanse = Service()
    
    func fetchingAPIData(handler: @escaping (_ apiData: [Product]) -> (Void)) {
        AF.request("https://dummyjson.com/products").response { (response) in
            print(response)
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode( Item.self, from: data!)
                    handler(jsondata.products)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  NetworkService.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import Foundation
class NetworkService : NetworkServiceProtocol{
    func getProducts(url: String, completionHandler: @escaping ([ProductClass]) -> Void) {
       
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let data = data {
                    do{
                        let jsonData = try JSONDecoder().decode([ProductElement].self, from: data)
                        let products = jsonData.map {$0.product}
                        completionHandler(products)
                    }catch{
                        print(response)
                        print(error)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
}

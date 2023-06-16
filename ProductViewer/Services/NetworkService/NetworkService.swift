//
//  NetworkService.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import Foundation
import UIKit
class NetworkService : NetworkServiceProtocol{
    func getProducts(url: String, completionHandler: @escaping ([ProductClass] , Error?) -> Void) {
       
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil{
                    DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                          }
                    return
                }
                if let data = data {
                    do{
                        let jsonData = try JSONDecoder().decode([ProductElement].self, from: data)
                        let products = jsonData.map {$0.product}
                        // sucessfully decode the model
                        completionHandler(products , nil)
                    }catch{
                        completionHandler([] , error)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
}

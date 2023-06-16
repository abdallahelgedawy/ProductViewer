//
//  ProductViewModel.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import Foundation
import RxSwift


class ProductViewModel{
    let products : PublishSubject<[ProductClass]> = PublishSubject()
    let disposeBag = DisposeBag()
    let network = NetworkService()
    var myProducts : [ProductClass] = []
    let database = CachingService.getInstance
    let favProducts : PublishSubject<[ProductClass]> = PublishSubject()
    //method to fetch api and insert products into database
    func getProducts(){
        network.getProducts(url: Constants.baseUrl) {[weak self] products , error in
            if error != nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            }
            else{
                self?.products.onNext(products)
                self?.products.onCompleted()
                self?.myProducts.append(contentsOf: products)
                for product in products {
                    self?.database.insertProduct(product: product,completion: { insert in
                        if insert == false{
                        DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                            }

                        }
                    })
                }
            }
        }
    }
    
    func getProductsFromDB(){
        database.getAllProducts { products in
            if products == nil {
                DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Error in fetching Data from Database", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }

            }
            else {
                self.favProducts.onNext(products!)
            }
        }
    }
    // send the object to the product details viewModel
    func instantiateProductDetails(index: Int) -> ProductDetailsViewModel? {
        guard index >= 0 else {
            return nil
        }
        
        let productDetailsViewModel = ProductDetailsViewModel()
            let productAtIndex = self.myProducts[index]
            productDetailsViewModel.detailedProducts.onNext(productAtIndex)
            return productDetailsViewModel
        
        
    }
    
    
}

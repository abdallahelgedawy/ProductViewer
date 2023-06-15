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
    func getProducts(){
        network.getProducts(url: Constants.baseUrl) {[weak self] products in
            self?.products.onNext(products)
            self?.products.onCompleted()
            self?.myProducts.append(contentsOf: products)
            print("gedo" , self?.myProducts.count)
            for product in products {
                
                self?.database.insertProduct(product: product,completion: { product in
                    print(product)
                })
            }
        }
    }
    func getProductsFromDB(){
        database.getAllProducts { products in
            self.favProducts.onNext(products!)
            
        }
    }
    func instantiateProductDetails(index: Int) -> ProductDetailsViewModel? {
        guard index >= 0 else {
            return nil
        }
        
        let productDetailsViewModel = ProductDetailsViewModel()
            let productAtIndex = self.myProducts[index]
           // print(productAtIndex)
            productDetailsViewModel.detailedProducts.onNext(productAtIndex)
          
            return productDetailsViewModel
        
        
    }
    
    
}

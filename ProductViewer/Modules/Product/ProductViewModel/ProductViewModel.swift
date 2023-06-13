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
    let database = CachingService.getInstance
    let favProducts : PublishSubject<[ProductClass]> = PublishSubject()
    func getProducts(){
        network.getProducts(url: Constants.baseUrl) {[weak self] products in
            self?.products.onNext(products)
            self?.products.onCompleted()
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
    }


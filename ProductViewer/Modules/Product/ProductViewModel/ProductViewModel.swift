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
    func getProducts(){
        network.getProducts(url: Constants.baseUrl) {[weak self] products in
                self?.products.onNext(products)
        }
    }
}

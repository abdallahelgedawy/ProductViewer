//
//  ProductDetailsViewModel.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import Foundation
import RxSwift
class ProductDetailsViewModel{
    let detailedProducts: BehaviorSubject<ProductClass?> = BehaviorSubject(value: nil)
        let disposeBag = DisposeBag()
        
        func getProductDetails() {
            detailedProducts
                .subscribe(onNext: { product in
                    if let product = product {
                        print(product.name)
                    } else {
                        print("No product available")
                    }
                })
                .disposed(by: disposeBag)
        }
     
}



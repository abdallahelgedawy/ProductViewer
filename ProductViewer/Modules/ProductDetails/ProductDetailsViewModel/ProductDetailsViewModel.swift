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
        // subscribe on the product sent from product viewModel
        func getProductDetails() {
            detailedProducts
                .subscribe(onNext: { product  in
                    if product != nil {
                        
                    } else {
                        DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "No Produc available", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                        }

                    }
                })
                .disposed(by: disposeBag)
        }
     
}



//
//  ProductCollectionViewController.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Reachability


class ProductCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    var reachability : Reachability?
    var isInitialPortraitOrientation = true
    let productViewModel = ProductViewModel()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = try? Reachability()
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "productCell")
        collectionView.delegate = nil
        collectionView.dataSource = nil
        setUpCollection()
        getProducts()
       
    }
}
    

    extension ProductCollectionViewController{
        
        func getProducts(){
                productViewModel.getProducts()
                
        }
        func setUpCollection(){
            if(reachability?.connection == Reachability.Connection.unavailable){
                productViewModel.getProductsFromDB()
                collectionView.rx.setDelegate(self).disposed(by: disposeBag)
                productViewModel.products.bind(to: collectionView.rx.items(cellIdentifier: "productCell",cellType: ProductCollectionViewCell.self)){ index , element , cell in
                    cell.setUpProduct(name: element.name, price: element.price, description: element.description, image: "notfound")
                    self.collectionView.reloadData()
                }.disposed(by: disposeBag)
            }
            else{
                collectionView.rx.setDelegate(self).disposed(by: disposeBag)
                productViewModel.products.bind(to: collectionView.rx.items(cellIdentifier: "productCell",cellType: ProductCollectionViewCell.self)){ index , element , cell in
                    cell.setUpProduct(name: element.name, price: element.price, description: element.description, image: "notfound")
                    self.collectionView.reloadData()
                }.disposed(by: disposeBag)
                
            }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let isLandscape = UIDevice.current.orientation.isLandscape
            let collectionViewWidth = collectionView.bounds.width
            let numberOfItemsPerRow: CGFloat = 2 // Adjust the number of items per row based on your desired layout
            let horizontalSpacing: CGFloat = 10 // Adjust the horizontal spacing between cells as needed
            
            let cellWidth = (collectionViewWidth - (numberOfItemsPerRow - 1) * horizontalSpacing) / numberOfItemsPerRow
            var cellHeight = collectionView.bounds.height / 2
            
            if isLandscape && collectionView.visibleCells.isEmpty {
                // Adjust the height for the first run of portrait mode
                cellHeight = collectionView.bounds.height
            }
            
            return CGSize(width: cellWidth, height: cellHeight)
        }

        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            
            coordinator.animate(alongsideTransition: { _ in
                self.collectionView.collectionViewLayout.invalidateLayout()
            }, completion: { _ in
                self.collectionView.reloadData()
            })
        }

    }



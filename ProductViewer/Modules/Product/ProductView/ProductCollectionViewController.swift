//
//  ProductCollectionViewController.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import UIKit



class ProductCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "productCell")
        collectionView.delegate = self
        
    }
    
    
}
    

    extension ProductCollectionViewController{
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }


        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of items
            return 4
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath)
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let isPortrait = UIDevice.current.orientation.isPortrait
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = isPortrait ? (collectionViewWidth - 30) / 2 : (collectionViewWidth - 10) / 2
            let cellHeight = isPortrait ? collectionView.bounds.height / 2 : collectionView.bounds.height
            
            return CGSize(width: cellWidth, height: cellHeight)
        }

        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            
            coordinator.animate(alongsideTransition: { _ in
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.reloadData()
            }, completion: nil)
        }
    }



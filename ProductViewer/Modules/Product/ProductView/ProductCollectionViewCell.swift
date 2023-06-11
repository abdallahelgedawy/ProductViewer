//
//  ProductCollectionViewCell.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        myView.layer.cornerRadius = 30
        productImage.layer.cornerRadius = 30
    }

}

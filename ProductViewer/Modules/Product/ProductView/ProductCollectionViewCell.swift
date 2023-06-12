//
//  ProductCollectionViewCell.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        myView.layer.cornerRadius = 30
        productImage.layer.cornerRadius = 30
    }
    func setUpProduct(name : String , price : String , description : String , image : String){
        productNameLabel.text = name
        productPriceLabel.text = price
        productDescriptionLabel.text = description
        productImage.image = UIImage(named: image ?? "")
    }
    

}

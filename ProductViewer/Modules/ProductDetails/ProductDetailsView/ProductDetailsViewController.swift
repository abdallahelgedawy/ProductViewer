//
//  ProductDetailsViewController.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 14/06/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var myView: UIStackView!
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        detailsImage.layer.cornerRadius = 20
        
    }
    @objc func handleOrientationChange() {
        if UIDevice.current.orientation.isLandscape {
            myView.axis = .horizontal
            myView.removeArrangedSubview(detailsLabel)
            myView.removeArrangedSubview(detailsImage)
            myView.addArrangedSubview(detailsImage)
            myView.addArrangedSubview(detailsLabel)
        } else {
            myView.axis = .vertical
            myView.removeArrangedSubview(detailsImage)
            myView.removeArrangedSubview(detailsLabel)
            myView.addArrangedSubview(detailsLabel)
            myView.addArrangedSubview(detailsImage)
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }


}

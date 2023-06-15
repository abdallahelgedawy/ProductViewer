//
//  ProductDetailsViewController.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 14/06/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var myView: UIStackView!
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    var productDetailsViewModel = ProductDetailsViewModel()
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        detailsImage.layer.cornerRadius = 20
        setUpViewController()
    }
    func setUpViewController(){
        productDetailsViewModel.detailedProducts.subscribe(onNext: { [weak self] product in
            DispatchQueue.main.async {
                self?.detailsLabel.text = product?.name ?? "No Data Available"
                self?.detailsImage.sd_setImage(with:URL(string: (product?.imageURL)!) , placeholderImage: UIImage(named: "notfound"))
            }
        }).disposed(by: disposeBag)
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

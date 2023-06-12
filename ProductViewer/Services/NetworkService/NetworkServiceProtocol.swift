//
//  NetworkServiceProtocol.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import Foundation
protocol NetworkServiceProtocol{
    func getProducts(url : String ,completionHandler : @escaping ([ProductClass])->Void)
}

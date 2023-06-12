//
//  Products.swift
//  ProductViewer
//
//  Created by Abdallah Elgedawy on 11/06/2023.
//

import Foundation
struct ProductElement: Codable {
    let product: ProductClass
    let productMerchants: [ProductMerchantElement]

    enum CodingKeys: String, CodingKey {
        case product = "Product"
        case productMerchants = "ProductMerchants"
    }
}

// MARK: - ProductClass
struct ProductClass: Codable {
    let id, name, description, price: String
    let unitPrice, productTypeID: JSONNull?
    let imageURL: String?
    let shoppingListItemID, shoppingCartItemID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, name, description, price
        case unitPrice = "unit_price"
        case productTypeID = "product_type_id"
        case imageURL = "image_url"
        case shoppingListItemID = "shopping_list_item_id"
        case shoppingCartItemID = "shopping_cart_item_id"
    }
}

// MARK: - ProductMerchantElement
struct ProductMerchantElement: Codable {
    let merchant: Merchant
    let merchantProduct: MerchantProduct
    let productMerchant: ProductMerchantProductMerchant

    enum CodingKeys: String, CodingKey {
        case merchant = "Merchant"
        case merchantProduct = "MerchantProduct"
        case productMerchant = "ProductMerchant"
    }
}

// MARK: - Merchant
struct Merchant: Codable {
    let id, name: String
}

// MARK: - MerchantProduct
struct MerchantProduct: Codable {
    let id, price, upc, sku: String
    let buyURL: String
    let discountPercent: String
    let unitPrice: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, price, upc, sku
        case buyURL = "buy_url"
        case discountPercent = "discount_percent"
        case unitPrice = "unit_price"
    }
}

// MARK: - ProductMerchantProductMerchant
struct ProductMerchantProductMerchant: Codable {
    let id, productID, upc, sku: String
    let created, modified, multipleProductsPerPage: String

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case upc, sku, created, modified
        case multipleProductsPerPage = "multiple_products_per_page"
    }
}

typealias Product = [ProductElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

//
//  ProductItemModel.swift
//  MVVMTestProject
//
//  Created by Arul on 12/19/18.
//  Copyright © 2018 Arul. All rights reserved.
//

import Foundation

typealias Products = [Product]

struct Product: Codable, Equatable {
    let pID, productName: String
    let price: Price
    let descr: String
    let mfgDate: String
    
    enum CodingKeys: String, CodingKey {
        case pID = "pId"
        case productName, price, descr, mfgDate
    }
}

struct Price: Codable {
    let currency: String?
    let amount: Amount
}

struct Amount: Codable {
    let rate: String
}

extension Product {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.price.amount.rate == rhs.price.amount.rate && lhs.pID == rhs.pID
    }
}

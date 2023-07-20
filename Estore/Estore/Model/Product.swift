//
//  Product.swift
//  Estore
//
//  Created by Denys on 1/6/23.
//

import SwiftUI
// Product Model...

struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}

// Product Types

enum ProductType: String, CaseIterable {
  case Wearable =  "Wearable"
  case Laptops =  "Laptops"
  case Phones =  "Phones"
  case Tablets =  "Tablets"
}

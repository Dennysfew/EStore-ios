//
//  SharedDataModel.swift
//  Estore
//
//  Created by Denys on 1/23/23.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    // Detail Product data...
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    // matched Geometry Effect form Search page...
    @Published var fromSearchPage: Bool = false
    
    //Liked Products...
    @Published var likedProducts: [Product] = []
    
    //Basked Products...
    @Published var cartProducts: [Product] = []
    
    //Calculating Total Price
    func getTotalPrice() -> String {
        var total: Int = 0
        
        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            
            let totalPrice = quantity * price.integerValue
            
            total += totalPrice
            
        }
        return "$\(total)"
    }
}


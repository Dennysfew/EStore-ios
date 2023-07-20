//
//  MoreProductsView.swift
//  Estore
//
//  Created by Denys on 1/11/23.
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        VStack {
            Text("More Products")
                .font(.system(size: 24).bold())
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}

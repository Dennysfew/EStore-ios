//
//  SearchView.swift
//  Estore
//
//  Created by Denys on 1/12/23.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    
    
    // Shared Data
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var homeData: HomeViewModel
    
    // Activating Text Field with the help of focusState
    @FocusState var startTF: Bool
    var body: some View {
        VStack(spacing: 0) {
            // SearchBar....
            HStack(spacing: 20) {
                
                //Close Button ....
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    // Resetting...
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                    
                }
                // SearchBar ...
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    //Since we need a separate view for search bar...
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .autocorrectionDisabled(true)
                    
                    
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color("Purple"), lineWidth: 1.5)
                )
                .padding(.trailing,20)
            }
            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)
            
            // Showing Progress if searching...
            // else showing no results found if empty ...
            if let products = homeData.searchProducts {
                
                if products.isEmpty {
                    // No results found ...
                    VStack(spacing: 10) {
                        
                        Image("NotFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        
                        Text("Item Not Found")
                            .font(.system(size: 22).bold())
                        
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        
                        
                    }
                    .padding()
                    
                } else {
                    // Filter Results ...
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        // Stagged Grid
                        
                        VStack(spacing: 0) {
                            
                            // Found Text
                            Text("Found \(products.count) results")
                                .font(.system(size: 24).bold())
                                .padding(.vertical)
                            
                            StaggedGrid(content: { product in
                                //Card View
                                ProductCartView(product: product)
                            }, list: products, columns: 2, spacing: 20)
                            
                        }
                        .padding()
                    }
                }
                
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("HomeBG")
                .ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
        
    }
    @ViewBuilder
    func ProductCartView(product: Product) -> some View {
        VStack(spacing: 10) {
         
            ZStack {
                if sharedData.showDetailProduct {
                    Image( product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image( product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            
            // Moving image to top to look like its fixed at half top ...
                .offset(y: -50)
                .padding(.bottom, -50)
            Text(product.title)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("Purple"))
                .padding(.top,5)
        }
        .padding(.horizontal,20)
        .padding(.bottom,22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top, 50)
        // Showing Product detail when tapped...
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

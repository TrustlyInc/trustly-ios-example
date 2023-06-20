//
//  ProductsListView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 16/06/23.
//

import SwiftUI

struct ProductsListView<ViewModel>: View where ViewModel: ProductListViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    let products = [Product(title: "Prime Ultraspeed Stunt", description: "Size 10.5", image:"product", quantity: 1, price: 90.0)]
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Image("logo").padding()
                
                List(viewModel.products) { product in
                        product.listRowSeparator(.hidden)
                    
                    Divider()
                }
                .listStyle(.plain)
                
                NavigationLink{
                    CartView(viewModel: CartViewModel(selectedProducts: products)).toolbarRole(.editor)
                } label: {
                    Text("Go to cart")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.ui.checkoutButton)
                        .border(Color.ui.checkoutButton)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()

                }

            }.navigationBarTitle("Purchase sneakers")
                .navigationBarTitleDisplayMode(.inline)
                
        }.onAppear{
            viewModel.fetchProductsCells()
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView(viewModel: ProductListViewModel())
    }
}

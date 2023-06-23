//
//  ProductsListView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 16/06/23.
//

import SwiftUI

struct ProductsListView<ViewModel>: View where ViewModel: ProductViewModelProtocol {
    
    @ObservedObject var viewModel: ViewModel
    @State private var isShowingCartView = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                Image("logo").padding()
                
                List($viewModel.products) { $product in
                    ProductCellView(product: $product, cellType: .catalog).listRowSeparator(.hidden)

                }
                .listStyle(.plain)
                
                Divider()
                
                Button{
                    isShowingCartView = true
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
            
            NavigationLink(destination: CartView().toolbarRole(.editor), isActive: $isShowingCartView) {
                EmptyView()
                
            }
                
        }.onAppear{
            viewModel.fetchProducts()
        }.environmentObject(viewModel)
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView(viewModel: ProductViewModel())
    }
}

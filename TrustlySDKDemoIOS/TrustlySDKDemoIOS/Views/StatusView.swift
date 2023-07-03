//
//  StatusView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import SwiftUI

struct StatusView<StatusViewModel>: View where StatusViewModel: StatusViewModelProtocol {
        
    @ObservedObject var statusViewModel: StatusViewModel
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack{
                    Image(statusViewModel.getStatusImage())
                    Text(statusViewModel.getStatusMessage())
                        .font(.custom("Open Sans", size: 28.0))
                        .fontWeight(.bold)
                        .foregroundColor(Color.ui.productQuantity)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button {
                        print("Back to checkout")
                    } label: {
                        Text("Back to checkout")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.ui.checkoutButton)
                            .border(Color.ui.checkoutButton)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.white, lineWidth: 2)
                            )
                            .cornerRadius(10)
                            .padding(.leading, 25)
                            .padding(.trailing, 25)
                    }
                    
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("Transaction details")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .border(Color.ui.checkoutButton)
                            .foregroundColor(Color.ui.checkoutButton)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.ui.checkoutButton, lineWidth: 2)
                            )
                            .cornerRadius(10)
                            .padding(.leading, 25)
                            .padding(.trailing, 25)
                    }
                }.navigationBarTitle("Purchase sneakers")
                    .navigationBarTitleDisplayMode(.inline)
                
                TransactionDetailView(viewModel: statusViewModel, show: $isPresented)
            }
            
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(statusViewModel: StatusViewModel())
    }
}

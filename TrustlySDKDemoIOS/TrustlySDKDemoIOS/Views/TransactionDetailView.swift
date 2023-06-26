//
//  TransactionDetailView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import SwiftUI

struct TransactionDetailView<ViewModel>: View where ViewModel: TransactionViewModelProtocol {
            
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Transaction details")
                    .font(.custom("Open Sans", size: 28.0))
                    .fontWeight(.bold)
                    .foregroundColor(Color.ui.transactionText)
                    .multilineTextAlignment(.center)
                Spacer()
                Text("X")
            }.padding()
            
            Divider()
            
            HStack {
                Text("transactionId")
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.regular)
                    .foregroundColor(Color.ui.transactionLabel)
                    .multilineTextAlignment(.center)
                Spacer()
                Text(viewModel.transaction.transactionId)
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.medium)
                    .foregroundColor(Color.ui.transactionText)
                    .multilineTextAlignment(.center)
            }.padding()
            
            HStack {
                Text("transactionType")
                    .fontWeight(.regular)
                    .foregroundColor(Color.ui.transactionLabel)
                    .multilineTextAlignment(.center)
                Spacer()
                Text(viewModel.transaction.transactionType)
            }.padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
            
            HStack {
                Text("paymentId")
                    .fontWeight(.regular)
                    .foregroundColor(Color.ui.transactionLabel)
                    .multilineTextAlignment(.center)
                Spacer()
                Text(viewModel.transaction.paymentId)
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.medium)
                    .foregroundColor(Color.ui.transactionText)
                    .multilineTextAlignment(.center)
            }.padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
            
            HStack {
                Text("paymentType")
                    .fontWeight(.regular)
                    .foregroundColor(Color.ui.transactionLabel)
                    .multilineTextAlignment(.center)
                Spacer()
                Text(viewModel.transaction.paymentType)
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.medium)
                    .foregroundColor(Color.ui.transactionText)
                    .multilineTextAlignment(.center)
            }.padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
            
            HStack {
                Text("status")
                    .fontWeight(.regular)
                    .foregroundColor(Color.ui.transactionLabel)
                    .multilineTextAlignment(.center)
                Spacer()
                Text(viewModel.transaction.status)
                    .font(.custom("Open Sans", size: 16.0))
                    .fontWeight(.medium)
                    .foregroundColor(Color.ui.transactionText)
                    .multilineTextAlignment(.center)
            }.padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
            
            Divider()
            
            Button {
                print("Close")
            } label: {
                Text("Close")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.ui.checkoutButton)
                    .border(Color.ui.checkoutButton)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 2)
                            )
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(viewModel: TransactionViewModel())
    }
}

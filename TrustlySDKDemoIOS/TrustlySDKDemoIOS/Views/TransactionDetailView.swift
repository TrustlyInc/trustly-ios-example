//
//  TransactionDetailView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import SwiftUI

struct TransactionDetailView<ViewModel>: View where ViewModel: StatusViewModelProtocol {
            
    @ObservedObject var viewModel: ViewModel
    @Binding var show: Bool
    
    var body: some View {
        
        ZStack {
            if show {
                if let transaction = viewModel.transaction {
                    Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                    VStack {
                        HStack {
                            Text("Transaction details")
                                .font(.custom("Open Sans", size: 28.0))
                                .fontWeight(.bold)
                                .foregroundColor(Color.ui.transactionText)
                                .multilineTextAlignment(.center)
                            Spacer()
                            Text("X")
                                .font(.custom("Open Sans", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color.ui.transactionText)
                                .multilineTextAlignment(.center)
                                .onTapGesture {
                                    show.toggle()
                            }
                        }.padding()

                        Divider()

                        HStack {
                            Text("transactionId")
                                .font(.custom("Open Sans", size: 16.0))
                                .fontWeight(.regular)
                                .foregroundColor(Color.ui.transactionLabel)
                                .multilineTextAlignment(.center)
                            Spacer()
                            Text(transaction.transactionId)
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
                            Text(transaction.transactionType.description())
                        }.padding(.leading)
                            .padding(.trailing)
                            .padding(.bottom)

                        HStack {
                            Text("paymentId")
                                .fontWeight(.regular)
                                .foregroundColor(Color.ui.transactionLabel)
                                .multilineTextAlignment(.center)
                            Spacer()
                            Text(transaction.paymentId ?? "")
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
                            Text(transaction.paymentType?.description() ?? "")
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
                            Text(transaction.status.description())
                                .font(.custom("Open Sans", size: 16.0))
                                .fontWeight(.medium)
                                .foregroundColor(Color.ui.transactionText)
                                .multilineTextAlignment(.center)
                        }.padding(.leading)
                            .padding(.trailing)
                            .padding(.bottom)

                        Divider()

                        Button {
                            show.toggle()
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
                    }.foregroundColor(.white)
                        .background(.white)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                                )
                        .cornerRadius(10)
                        .padding(.leading, 25)
                        .padding(.trailing, 25)

                } else {
                    Text("Invalid transaction")
                }
            }
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var transaction = Transaction(transactionId: "123456", transactionType: .External, status: .Authorized, panel: "1", url: "", merchantReference: "", requestSignature: "", paymentId: "654321", paymentType: .Retrieval, paymentProviderType: "", paymentAccountVerified: "")
    
    @State static var show = true
    
    static var previews: some View {
        TransactionDetailView(viewModel: StatusViewModel(transaction: transaction), show: $show)
    }
}

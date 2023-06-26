//
//  TransactionViewModel.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import Foundation

protocol TransactionViewModelProtocol: ObservableObject {
    var transaction: Transaction { get set }
    
    func fetchTransaction()
    
}

class TransactionViewModel: TransactionViewModelProtocol {
    
    @Published var transaction: Transaction = buildTrasaction()
    
    func fetchTransaction() {
        transaction = Transaction(transactionId: "1002633191",
                                      transactionType: "Authorize",
                                      paymentId: "1023729526",
                                      paymentType: "Deferred",
                                      status: "Pending")
    }
    
    private static func buildTrasaction() -> Transaction {
        return Transaction(transactionId: "1002633191",
                              transactionType: "Authorize",
                              paymentId: "1023729526",
                              paymentType: "Deferred",
                              status: "Pending")

    }
    
}

//
//  PaymentViewModel.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import Foundation

protocol PaymentViewModelProtocol: ObservableObject {
    var transaction: Transaction? { get set }
    
    func createTransaction(response: [String:String]) -> Void
    func paymentAuthorized() -> Bool
    func fetchTransaction()
    
}

class PaymentViewModel: PaymentViewModelProtocol {
    
    @Published var transaction: Transaction? = nil
    
    func paymentAuthorized() -> Bool {
        guard let transaction = self.transaction else { return false }
        
        return transaction.status == TransactionStatus.Authorized
    }
    
    func fetchTransaction() {
//        transaction = Transaction(transactionId: "1002633191",
//                                      transactionType: "Authorize",
//                                      paymentId: "1023729526",
//                                      paymentType: "Deferred",
//                                      status: "Pending")
    }
    
//    private static func buildTrasaction() -> Transaction {
//        return Transaction(transactionId: "1002633191",
//                              transactionType: "Authorize",
//                              paymentId: "1023729526",
//                              paymentType: "Deferred",
//                              status: "Pending")
//
//    }
    
    func createTransaction(response: [String:String]) -> Void {
        do {

            let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
            
            transaction = try JSONDecoder().decode(Transaction.self, from: jsonData)
        } catch {
            print(error)
        }
    }
    
}

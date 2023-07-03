//
//  StatusViewModel.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import Foundation

protocol StatusViewModelProtocol: ObservableObject {

    var transaction: Transaction? { get set }
    
    func getStatusMessage() -> String
    func getStatusImage() -> String
    
}

class StatusViewModel: StatusViewModelProtocol {
    
    @Published var transaction: Transaction?
    
    private let messageSuccess = "Payment Type\nAdded Successfully"
    private let messageFailure = "Payment Authorization\nCanceled"
    private let imageSuccess = "icon_success"
    private let imageFailure = "icon_failure"
    
    init () {

    }
    
    init (transaction: Transaction?) {
        self.transaction = transaction
    }

    func getStatusMessage() -> String {
        if isSuccess() {
            return messageSuccess
            
        } else {
            return messageFailure
            
        }
    }
    
    func getStatusImage() -> String {
        if isSuccess() {
            return imageSuccess
            
        } else {
            return imageFailure
            
        }
    }
    
    private func isSuccess() -> Bool {
        guard let transaction = self.transaction else { return false }
        
        return transaction.status == TransactionStatus.Authorized
    }
    
}

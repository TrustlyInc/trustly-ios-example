//
//  Transaction.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import Foundation


struct Transaction: Hashable, Identifiable, Codable {
    var id = UUID()
    let transactionId: String
    let transactionType: TransactionType
    let status: TransactionStatus
    let panel: String
    let url: String
    let merchantReference: String
    let requestSignature: String
    let paymentId: String?
    let paymentType: PaymentType?
    let paymentProviderType: String?
    let paymentAccountVerified: String?
    
    enum CodingKeys: String, CodingKey {
        case transactionId
        case transactionType
        case status
        case panel
        case url
        case merchantReference
        case requestSignature
        case paymentId
        case paymentType = "payment.paymentType"
        case paymentProviderType = "payment.paymentProvider.type"
        case paymentAccountVerified = "payment.account.verified"
    }

}

enum TransactionStatus: String, Codable {
    case New = "0"
    case Pending = "1"
    case Authorized = "2"
    case Processed = "3"
    case Completed = "4"
    case Failed = "5"
    case Expired = "6"
    case Canceled = "7"
    case Denied = "8" 
    case Reversed = "10"
    case PartiallyRefunded = "11"
    case Refunded = "12"
    case Voided = "13"
    case OnHold = "14"
    
    func description() -> String {
        switch self {
        case .New: return "New"
        case .Pending: return "Pending"
        case .Authorized: return "Authorized"
        case .Processed: return "Processed"
        case .Completed: return "Completed"
        case .Failed: return "Failed"
        case .Expired: return "Expired"
        case .Canceled: return "Canceled"
        case .Denied: return "Denied"
        case .Reversed: return "Reversed"
        case .PartiallyRefunded: return "Partially Refunded"
        case .Refunded: return "Refunded"
        case .Voided: return "Voided"
        case .OnHold: return "On Hold"
        }
    }
}

enum TransactionType: String, Codable {
    case External = "0"
    case Authorize = "1"
    case Pay = "2"
    case Capture = "3"
    case Refund = "4"
    case Reverse = "5"
    case Deposit = "6"
    case Reclaim = "7"
    case Representment = "8"
    case Tokenization = "9"
    case Preauthorization = "10"
    case Guarantee = "11"
    
    func description() -> String {
        switch self {
        case .External: return "External"
        case .Authorize: return "Authorize"
        case .Pay: return "Pay"
        case .Capture: return "Capture"
        case .Refund: return "Refund"
        case .Reverse: return "Reverse"
        case .Deposit: return "Deposit"
        case .Reclaim: return "Reclaim"
        case .Representment: return "Representment"
        case .Tokenization: return "Tokenization"
        case .Preauthorization: return "Preauthorization"
        case .Guarantee: return "Guarantee"
        }
    }
}

enum PaymentType: String, Codable {
    case Deferred = "2"
    case Recurring = "3"
    case Disbursement = "4"
    case Verification = "5"
    case Retrieval = "6"
    
    func description() -> String {
        switch self {
        case .Deferred: return "Deferred"
        case .Recurring: return "Recurring"
        case .Disbursement: return "Disbursement"
        case .Verification: return "Verification"
        case .Retrieval: return "Retrieval"
        }
    }
}

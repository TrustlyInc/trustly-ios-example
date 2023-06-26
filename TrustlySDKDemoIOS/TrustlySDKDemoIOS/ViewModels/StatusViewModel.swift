//
//  StatusViewModel.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 26/06/23.
//

import Foundation

protocol StatusViewModelProtocol: ObservableObject {
    var isSuccess: Bool { get set }
    
    func getStatusMessage() -> String
    func getStatusImage() -> String
    
}

class StatusViewModel: StatusViewModelProtocol {
    
    @Published var isSuccess: Bool
    
    private let messageSuccess = "Payment Type\nAdded Successfully"
    private let messageFailure = "Payment Authorization\nCanceled"
    private let imageSuccess = "icon_success"
    private let imageFailure = "icon_failure"
    
    init (isSuccess: Bool) {
        self.isSuccess = isSuccess
    }

    func getStatusMessage() -> String {
        if isSuccess {
            return messageSuccess
            
        } else {
            return messageFailure
            
        }
    }
    
    func getStatusImage() -> String {
        if isSuccess {
            return imageSuccess
            
        } else {
            return imageFailure
            
        }
    }
    
}

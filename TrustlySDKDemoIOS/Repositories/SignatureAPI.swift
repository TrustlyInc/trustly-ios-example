//
//  SignatureAPI.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 30/11/23.
//

import Foundation

protocol SignatureAPIProtocol {
    func generateRequestSignatureFor(establishData: Dictionary<AnyHashable, Any>, completionHandler: @escaping (Result<String, NSError>) -> Void)
}


class SignatureAPI: BaseAPI<RepositoriesNetworking>, SignatureAPIProtocol {
    
    func generateRequestSignatureFor(establishData: Dictionary<AnyHashable, Any>, completionHandler: @escaping (Result<String, NSError>) -> Void) {
        self.fetchData(target: .postRequestSignature(establishData: establishData)) { (result) in
            completionHandler(result)
        }
    }
    
}

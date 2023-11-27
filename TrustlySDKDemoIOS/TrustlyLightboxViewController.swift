//
//  TrustlyLightboxViewController.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 13/01/23.
//

import UIKit
import TrustlySDK

protocol TrustlyLightboxViewProtocol {
    func onReturnWithTransactionId(transactionId: String, controller: TrustlyLightboxViewController)
    func onCancelWithTransactionId(transactionId: String, controller: TrustlyLightboxViewController)
}


class TrustlyLightboxViewController: UIViewController {
    
    var establishData:Dictionary<AnyHashable,Any> = [:]
    var delegate: TrustlyLightboxViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trustlyLightboxPanel = TrustlyView()
                
        self.view = trustlyLightboxPanel.establish(establishData: establishData,
                                                   onReturn: {(trustlyView, returnParameters)->Void in
            let response = returnParameters as! [String:String]
            self.delegate?.onReturnWithTransactionId(transactionId: response["transactionId"]!, controller: self)
            
        }, onCancel: {(payWithMyBank, returnParameters)->Void in
            let response = returnParameters as! [String:String]
            self.delegate?.onCancelWithTransactionId(transactionId: response["transactionId"]!, controller: self)
        })
        
    }
    
}

//
//  PayWithMyBankViewController.swift
//  PayWithMyBankSDKDemoIOS
//
//  Created by Marcos Rivereto on 13/01/23.
//

import UIKit
import PayWithMyBank

protocol PayWithMyBankViewProtocol {
    func onReturnWithTransactionId(transactionId: String, controller: PayWithMyBankViewController)
    func onCancelWithTransactionId(transactionId: String, controller: PayWithMyBankViewController)
}


class PayWithMyBankViewController: UIViewController {
    
    var establishData:Dictionary<AnyHashable,Any>?
    var delegate: PayWithMyBankViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let payWithMyBankPanel = PayWithMyBankView()
                
        self.view = payWithMyBankPanel.establish(self.establishData , onReturn: {(payWithMyBank, returnParameters)->Void in
                let response = returnParameters as! [String:String]
                self.delegate?.onReturnWithTransactionId(transactionId: response["transactionId"]!, controller: self)
            
            }, onCancel: {(payWithMyBank, returnParameters)->Void in
                let response = returnParameters as! [String:String]
                self.delegate?.onCancelWithTransactionId(transactionId: response["transactionId"]!, controller: self)
        })
        
    }
    
}

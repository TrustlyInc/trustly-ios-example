/*  ___________________________________________________________________________________________________________
 *
 *    TRUSTLY CONFIDENTIAL AND PROPRIETARY INFORMATION
 *  ___________________________________________________________________________________________________________
 *
 *      Copyright (c) 2012 - 2020 Trustly
 *      All Rights Reserved.
 *
 *   NOTICE:  All information contained herein is, and remains, the confidential and proprietary property of
 *   Trustly and its suppliers, if any. The intellectual and technical concepts contained herein are the
 *   confidential and proprietary property of Trustly and its suppliers and  may be covered by U.S. and
 *   Foreign Patents, patents in process, and are protected by trade secret or copyright law. Dissemination of
 *   this information or reproduction of this material is strictly forbidden unless prior written permission is
 *   obtained from Trustly.
 *   ___________________________________________________________________________________________________________
*/

import UIKit
import TrustlySDK

class MerchantViewController: UIViewController {

    @IBOutlet weak var trustlyBankView: TrustlyView!
    @IBOutlet weak var amountTextView: UITextField!
    var establishData:Dictionary<AnyHashable,Any> = [:]
    var MERCHANT_ID = "YOUR_MERCHANT_ID"
    var ACCESS_ID = "YOUR_ACCESS_ID"
    var APP_DEEP_LINK = "demoapp://"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.establishData = [
//            "accessId": ACCESS_ID,
//            "merchantId" : MERCHANT_ID,
//            "description" : "Globex Demo",
//            "merchantReference" : "unique_transaction_reference_001",
//            "amount": "0.00",
//            "paymentType":"Deferred",
//            "currency":"USD",
//            "metadata.urlScheme": APP_DEEP_LINK,
//            "metadata.integrationContext": "InAppBrowser",
//            "env":"sandbox"
//        ]
        
        self.establishData = ["accessId": "A48B73F694C4C8EE6307",
                              "merchantId" : "1009542823",
                              "currency" : "USD",
                              "amount" : "1.00",
                              "merchantReference" : "3D51F3A42EFE499A",
                              "paymentType" : "Retrieval",
                              "returnUrl": "/returnUrl",
                              "cancelUrl": "/cancelUrl",
                              "requestSignature": "HT5mVOqBXa8ZlvgX2USmPeLns5o=",
                              "customer.name": "John",
                              "customer.address.country": "US",
                              "metadata.urlScheme": "demoapp://",
                              "description": "Globex Demo",
                              "env": "sandbox",
                              "localUrl": "192.168.0.13:8000"]
        
        self.trustlyBankView.onChangeListener { (eventName, attributes) in
            print("onChangeListener: \(eventName) \(attributes)")
        }

        self.trustlyBankView.selectBankWidget(establishData: establishData) { (view, data) in
            print("returnParameters:\(data)")
            self.establishData = data
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBActions
    
    @IBAction func pay(_ sender: Any) {
        
        let trustlyLightboxViewController = TrustlyLightboxViewController()
        trustlyLightboxViewController.delegate = self

        if let amountText = amountTextView.text,
           let amount = Double(amountText) {
            
            establishData["amount"] = String(format: "%.2f", amount)
            trustlyLightboxViewController.establishData = establishData
            
            self.present(trustlyLightboxViewController, animated: true)
        }
        
    }
    
}

extension MerchantViewController: TrustlyLightboxViewProtocol {
    
    func onReturnWithTransactionId(transactionId: String, controller: TrustlyLightboxViewController) {
        controller.dismiss(animated: true)
    }
    
    func onCancelWithTransactionId(transactionId: String, controller: TrustlyLightboxViewController) {
        controller.dismiss(animated: true)
    }

}

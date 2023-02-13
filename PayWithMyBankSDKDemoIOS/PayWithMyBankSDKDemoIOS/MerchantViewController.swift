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
import PayWithMyBank

class MerchantViewController: UIViewController {

    @IBOutlet weak var payWithMyBankView: PayWithMyBankView!
    @IBOutlet weak var amountTextView: UITextField!
    var establishData:Dictionary<AnyHashable,Any> = [:]
    var payWithMyBankPanel = PayWithMyBankView()
    var MERCHANT_ID = "YOUR_MERCHANT_ID"
    var ACCESS_ID = "YOUR_ACCESS_ID"
    var APP_DEEP_LINK = "demoapp://"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.establishData = [
            "accessId": ACCESS_ID,
            "merchantId" : MERCHANT_ID,
            "description" : "Globex Demo",
            "merchantReference" : "unique_transaction_reference_001",
            "amount": "0.00",
            "paymentType":"Deferred",
            "currency":"USD",
            "metadata.urlScheme": APP_DEEP_LINK,
            "metadata.integrationContext": "InAppBrowser",
            "env":"sandbox"
        ]
        
        self.payWithMyBankView.onChangeListener { (eventName, attributes) in
            if let event = eventName, let data = attributes {
                print("onChangeListener: \(event) \(data)")
            }
        }

        self.payWithMyBankView.selectBankWidget(establishData) { (view, data) in
            if let data = data {
                print("returnParameters:\(data)")
                self.establishData = data
            }
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

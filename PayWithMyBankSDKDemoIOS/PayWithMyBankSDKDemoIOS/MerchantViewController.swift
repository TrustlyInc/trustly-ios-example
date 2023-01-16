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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.establishData = ["accessId": "A48B73F694C4C8EE6307",
                           "merchantId" : "1009542823",
                           "description" : "Globex Demo",
                           "merchantReference" : "3D51F3A42EFE499A",
                           "amount": "0.00",
                           "paymentType":"Retrieval",
                           "customer.name":"Freddie Mercury",
                           "customer.address.address1":"96725 Champlin Shoal",
                           "customer.address.address2":"#86",
                           "customer.address.city":"London",
                           "customer.address.state":"London",
                           "customer.address.zip":"DZ03 1WN",
                           "customer.address.country":"US",
                           "customer.phone":"+44 123456789",
                           "customer.email":"freddie.mercury@email.com",
                           "currency":"USD",
                           "metadata.lang":"en_GB",
                           "metadata.urlScheme": "demoapp://",
                              "metadata.integrationContext": "InAppBrowser",
                           "env":"sandbox"]
        
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
        
        let payWithMyBankViewController = PayWithMyBankViewController()
        payWithMyBankViewController.delegate = self

        if let amountText = amountTextView.text,
           let amount = Double(amountText) {
            
            establishData["amount"] = String(format: "%.2f", amount)
            payWithMyBankViewController.establishData = establishData
            
            self.present(payWithMyBankViewController, animated: true)
        }
        
    }
    
}

extension MerchantViewController: PayWithMyBankViewProtocol {
    
    func onReturnWithTransactionId(transactionId: String, controller: PayWithMyBankViewController) {
        controller.dismiss(animated: true)
    }
    
    func onCancelWithTransactionId(transactionId: String, controller: PayWithMyBankViewController) {
        controller.dismiss(animated: true)
    }

}

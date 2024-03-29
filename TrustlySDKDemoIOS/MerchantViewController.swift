import UIKit
import TrustlySDK

class MerchantViewController: UIViewController {

    @IBOutlet weak var trustlyView: TrustlyView!
    @IBOutlet weak var amountTextView: UITextField!
    var establishData:Dictionary<AnyHashable,Any> = [:]
    var trustlyPanel = TrustlyView()
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
                
        self.trustlyView.onChangeListener { (eventName, attributes) in
            print("onChangeListener: \(eventName) \(attributes)")
        }

        _ = self.trustlyView.selectBankWidget(establishData: establishData) { (view, data) in
            print("returnParameters:\(data)")
            self.establishData = data
            self.openLightbox()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openLightbox() {
        
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

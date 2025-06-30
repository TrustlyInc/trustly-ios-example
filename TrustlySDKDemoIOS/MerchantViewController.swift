import UIKit
import TrustlySDK

class MerchantViewController: BaseViewController {

    @IBOutlet weak var amountTextView: UITextField!
    
    private let signatureApi = RequestSignatureAPI()
    private var lightboxViewController: LightBoxViewController?
    
    var establishData:Dictionary<AnyHashable,Any> = [:]
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
            "customer.name": "John",
            "customer.address.country": "US",
            "metadata.urlScheme": APP_DEEP_LINK,
            "metadata.integrationContext": "InAppBrowser",
            "env":"sandbox"
        ]
        
        let widgetVC = WidgetViewController(establishData: establishData)
        widgetVC.delegate = self

        widgetVC.view.frame = CGRect(x: 16, y: 220, width: 350, height: 500)
        view.addSubview(widgetVC.view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openLightbox() {
        if let amountText = amountTextView.text,
           let amount = Double(amountText) {
            
            establishData["amount"] = String(format: "%.2f", amount)
        } else {
            establishData["amount"] = "0.00"
        }
        
        lightboxViewController = LightBoxViewController(establishData: establishData)
        lightboxViewController?.delegate = self

        self.present(lightboxViewController!, animated: true)
        
    }
    
}

extension MerchantViewController: TrustlySDKProtocol {
    func onReturn(_ returnParameters: [AnyHashable : Any]) {
        lightboxViewController?.dismiss(animated: true)
        
        showSuccessAlert()

    }
    
    func onCancel(_ returnParameters: [AnyHashable : Any]) {
        lightboxViewController?.dismiss(animated: true)
        
        showFailureAlert()

    }
    
    func onBankSelected(data: [AnyHashable: Any]) {
        print("returnParameters:\(data)")
        
        self.establishData = data
        
        /* Uncomment this function only if your merchant setup has the "Extended Security" enable in Admin console, and uncomment the code between the lines
        84-96 */
//        showSpinner()
//        self.updateEstablishWithRequestSignature()
        
        /* Remove this line, if your merchant setup has the "Extended Security" enable in Admin console */
        self.openLightbox()
    }
    
    func onExternalUrl(onExternalUrl: TrustlyViewCallback?) {
        print("onExternalUrl")
    }
    
    func onChangeListener(_ eventName: String, _ eventDetails: [AnyHashable : Any]) {
        print("eventName: \(eventName), eventDetails: \(eventDetails)")
    }
}


extension MerchantViewController {

    /* Uncomment this fuction if your merchant setup has the "Extended Security" enable in Admin console,
       and if did you alredy iimplemented in your backend the generate Request Signature endpoint.
    */
//    func updateEstablishWithRequestSignature() {
//
//        signatureApi.generateRequestSignatureFor(establishData: self.establishData) { (result) in
//            do {
//                try self.establishData["requestSignature"] = result.get()
//                print("generateRequestSignature - requestSignature: \(String(describing: self.establishData["requestSignature"]))")
//                
//                self.showSpinner(false)
//                
//                self.openLightbox()
//
//            } catch {
//                print("Error trying to get requestSignature")
//            }
//        }
//    }
}

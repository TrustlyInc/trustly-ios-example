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
    
    let signatureApi = RequestSignatureAPI()
    var establishData:Dictionary<AnyHashable,Any> = [:]
    var delegate: TrustlyLightboxViewProtocol?
    
    var spinner = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showSpinner()
        /* Uncomment this function only if your merchant setup has the "Extended Security" enable in Admin console, and uncomment the code between the lines
        79-93 */
        //self.updateEstablishWithRequestSignature()
                
    }
    
    func showSpinner(_ show: Bool = true) {
        
        if show {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.7)
            
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.startAnimating()
            self.view.addSubview(spinner)
            
            spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            
        } else {
            self.view.backgroundColor = UIColor.systemBackground
            spinner.removeFromSuperview()
        }

    }
    
    private func buildLightbox() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        let trustlyLightboxPanel = TrustlyView()
                
        self.view = trustlyLightboxPanel.establish(establishData: establishData,
                                                   onReturn: {(trustlyView, returnParameters)->Void in
            let response = returnParameters as! [String:String]
            self.delegate?.onReturnWithTransactionId(transactionId: response["transactionId"]!, controller: self)
            
        }, onCancel: {(payWithMyBank, returnParameters)->Void in
            let response = returnParameters as! [String:String]
            self.delegate?.onCancelWithTransactionId(transactionId: response["transactionId"]!, controller: self)
        })
        
        self.showSpinner(false)
    }
    
}

//MARK: Network extension
extension TrustlyLightboxViewController {

    /* Uncomment this fuction if your merchant setup has the "Extended Security" enable in Admin console,
       and if did you alredy iimplemented in your backend the generate Request Signature endpoint.
    */
//    func updateEstablishWithRequestSignature() {
//        
//        signatureApi.generateRequestSignatureFor(establishData: self.establishData) { (result) in
//            do {
//                try self.establishData["requestSignature"] = result.get()
//                print("generateRequestSignature - requestSignature: \(self.establishData["requestSignature"])")
//                
//                self.buildLightbox()
//                
//            } catch {
//                print("Error trying to get requestSignature")
//            }
//        }
//    }
}

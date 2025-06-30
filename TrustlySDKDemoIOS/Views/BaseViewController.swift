//
//  BaseViewController.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 30/06/25.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Alert functions
    private func showAlert(title: String, message: String){
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
         })

        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }

    func showSuccessAlert(){
        self.showAlert(title: "Success", message: "Authentication success!")
    }
    
    func showFailureAlert(){
        self.showAlert(title: "Failure", message: "Failure when to try to process your payment. Try again later")
    }
}

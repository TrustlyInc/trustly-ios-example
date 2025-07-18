//
//  BaseViewController.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 30/06/25.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .medium)
    
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
    
    // MARK: Spinner
    func showSpinner(_ show: Bool = true) {
        
        if show {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.7)
            
            spinner.color = .white
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
}

//
//  TrustlySDK.swift
//  Pods
//

import Foundation
import UIKit

public typealias TrustlyCallback = (_ trustlyView: UIView, _ returnParameters: [AnyHashable : Any]) -> Void;
public typealias ExternalUrlCallback = (_ request: NSURLRequest?) -> Void?;
public typealias TrustlyListenerCallback = (_ eventName: String, _ eventDetails: [AnyHashable : Any]) -> Void;


protocol TrustlyProtocol {
        
    /*!
        @brief Establishes a new transaction. Shows the bank authentication on the TrustlyView
        @param estabilishData The dictionary containing the establish data
        @param onReturn Called when the user flow finishes and control is returned to the application.The returnParameters has as entries the same parameters of the returnURL on the web (check the definition on the Integration Guide).
        @param onCancel Called when the user cancels the flow and the control is returned to the application.The returnParameters has as entries the same parameters of the returnURL on the web (check the definition on the Integration Guide)
    */
    func establish (establishData: [AnyHashable : Any],
                 onReturn: TrustlyCallback?,
                 onCancel: TrustlyCallback?) -> UIView?;

    /*!
        @brief Shows the select bank widget on the TrustlyView
        @param estabilishData The dictionary containing the establish data. Similar to the establishData object on the JavaScript API.
        @param onBankSelected Called when the user selects a bank on the widget. The callback returnParameters dictionaryis the mutable clone of the establishData with an additional entry for the key “paymentProviderId” with the id of the selected bank.
    */
    func selectBankWidget(establishData: [AnyHashable : Any], onBankSelected: TrustlyCallback?) -> UIView?;


    func verify(verifyData: [AnyHashable : Any], onReturn:TrustlyCallback?, onCancel: TrustlyCallback? ) -> UIView?;

    /*!
        @brief Shows a hybrid page that will establish a new transaction
        @param url Initial page URL.
        @param returnUrl returnUrl parameter set on the establish data
        @param onReturn Called when the user flow finishes and control is returned to the application.The returnParameters has as entries the same parameters of the returnURL on the web (check the definition on the Integration Guide).
        @param cancelUrl cancelUrl parameter set on the establish data
        @param onCancel Called when the user cancels the flow and the control is returned to the application.The returnParameters has as entries the same parameters of the returnURL on the web (check the definition on the Integration Guide)
    */
    func hybrid(url: String, returnUrl: String, onReturn: TrustlyCallback?, cancelUrl: String, onCancel: TrustlyCallback?) -> UIView?;

    /*!
        @brief Sets a callback to handle external URLs
        @param onExternalUrl Called when the TrustlySDK panel must open an external URL. If not handled an internal in app WebView willshow the external URL.The external URL is sent on the returnParameters entry key “url”.
    */
    func onExternalUrl(onExternalUrl: TrustlyCallback?) -> Void;
    func onChangeListener(onChangeListener: TrustlyListenerCallback?) -> Void;
}

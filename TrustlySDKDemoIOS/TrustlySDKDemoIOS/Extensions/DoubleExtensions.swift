//
//  StringExtensions.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 16/06/23.
//

import Foundation


extension Double {
    func toCurrencyFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current//Locale(identifier: "ig_NG")/* Using Nigeria's Naira here or you can use Locale.current to get current locale, please change to your locale, link below to get all locale identifier.*/
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

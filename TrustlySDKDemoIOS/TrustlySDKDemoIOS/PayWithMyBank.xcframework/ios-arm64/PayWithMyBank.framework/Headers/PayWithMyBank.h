#ifndef PayWithMyBank_Header_h
#define PayWithMyBank_Header_h
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
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

//! Project version number for PayWithMyBank.
FOUNDATION_EXPORT double PayWithMyBankVersionNumber;

//! Project version string for PayWithMyBank.
FOUNDATION_EXPORT const unsigned char PayWithMyBankVersionString[];

/*!
    @brief PayWithMyBankView callback function definition
    @param payWithMyBankView The PayWithMyBankView object that is calling the callback handle
    @param returnParameters The dictionary containing the returned parameters from the PayWithMyBankView
*/
typedef void (^PayWithMyBankCallback)(UIView *payWithMyBankView, NSDictionary *returnParameters);
typedef void (^ExternalUrlCallback)(NSURLRequest * request);
typedef void (^PayWithMyBankListenerCallback)(NSString *eventName, NSMutableDictionary *eventDetails);

@protocol PayWithMyBankProtocol <NSObject>

/*!
    @brief Establishes a new transaction. Shows the bank authentication on the PayWithMyBankView
    @param estabilishData The dictionary containing the establish data
    @param onReturn Called when the user flow finishes and control is returned to the application.The returnParameters has as entries the same parameters of the returnURL on the web (check the definition on the Integration Guide).
    @param onCancel Called when the user cancels the flow and the control is returned to the application.The returnParameters has as entries the same parameters of the returnURL on the web (check the definition on the Integration Guide)
*/
- (UIView *)establish:(NSDictionary *)estabilishData
             onReturn:(PayWithMyBankCallback)onReturn
             onCancel:(PayWithMyBankCallback)onCancel;

/*!
    @brief Shows the select bank widget on the PayWithMyBankView
    @param estabilishData The dictionary containing the establish data. Similar to the establishData object on the JavaScript API.
    @param onBankSelected Called when the user selects a bank on the widget. The callback returnParameters dictionaryis the mutable clone of the establishData with an additional entry for the key “paymentProviderId” with the id of the selected bank.
*/
- (UIView *)selectBankWidget:(NSDictionary *)estabilishData
             onBankSelected:(PayWithMyBankCallback)onBankSelected;


- (UIView *)verify:(NSDictionary *)verifyData
          onReturn:(PayWithMyBankCallback)onReturn
          onCancel:(PayWithMyBankCallback)onCancel;

/*!
    @brief Shows a hybrid page that will establish a new transaction
    @param url Initial page URL.
    @param returnUrl returnUrl parameter set on the establish data
    @param onReturn Called when the user flow finishes and control is returned to the application.The returnParameters has as entries the same parameters of the returnURL on the web (check the definition on the Integration Guide).
    @param cancelUrl cancelUrl parameter set on the establish data
    @param onCancel Called when the user cancels the flow and the control is returned to the application.The returnParameters has as entries the same parameters of the returnURL on the web (check the definition on the Integration Guide)
*/
- (UIView *)hybrid:(NSString *)url
          returnUrl:(NSString *)returnUrl
          onReturn:(PayWithMyBankCallback)onReturn
          cancelUrl: (NSString *)cancelUrl
          onCancel:(PayWithMyBankCallback)onCancel;

/*!
    @brief Sets a callback to handle external URLs
    @param onExternalUrl Called when the PayWithMyBank panel must open an external URL. If not handled an internal in app WebView willshow the external URL.The external URL is sent on the returnParameters entry key “url”.
*/
- (void) onExternalUrl:(PayWithMyBankCallback)onExternalUrl;

- (void) onChangeListener:(PayWithMyBankListenerCallback)onChangeListener;

@end

#endif

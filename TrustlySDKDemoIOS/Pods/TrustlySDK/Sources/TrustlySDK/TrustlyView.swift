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
import WebKit
import AuthenticationServices
import SafariServices

func Rgb2UIColor(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
}

let WidgetView:Int = 100

let ExternalLinkViewTag:Int = 99
let ExternalLinkTitleTag:Int = 98
let ExternalLinkSubtitleTag:Int = 97
let ExternalLinkWebViewTag:Int = 96
let ExternalLinkPrintBtnTag:Int = 95

let NavBarHeight:Int = 26
let NavBarIconWidth:Int = 10
let NavBarIconHeight:Int = 10

let build = "3.0.0"

let CloseIconBase64:String! = "iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAACXBIWXMAACxLAAAsSwGlPZapAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAG1SURBVHgB3diLTcNADAZgpxOUBVA6CYzQDdoRGMETABMAG8AEVUdggmaDdoMYn5KTQlSau8RnW/ySVUWyo/sa9XEH8E9SDS+IaM0vO647rmNVVUdwFF5feAlr3HLVXN+8xq9x047rQr/zAk4SEFwbrma0xhNXHZvqK4iYdzDODUTMITbu6XbMMAmIkHbV968n7re3wFD3mdhwhXe8Thl4pLSoYRKfRMxpOPhBaSmOyUS0XLvxDcwxmYgQ/OtGZhgxhCVGHGGBKYbQxBRHaGDUECUx6ogSGDOEJMYcIYFxg1iKcYWYi6Fuz9MkziBoJgPz6RYxA+MXIYxB8JCFGARPmYlB8JhMDIJQViAY6s6XHjJG7sFTKP8Xe5g38JCFCB8YIYQtRhhhg5mBQEr/NtPB0IK/4m4wtHA/wdeVOYaENkWmGBLe2ZlgqND2VBVDhffYKhhSOigoiiHl044iGDI6shHFkPG5kwjGGiGG8YBYjKHuaTSJgwgKycQ8x6Ft4gCCYjIw5ziACc0IBknEtLF56okgGCYB0w6bT9carBExExgcNtZch37xoc5cT+AoPeZ1ALhExA8NsASbTxPzlwAAAABJRU5ErkJggg=="
    
@available(iOS 12.0, *)
public class TrustlyView : UIView, TrustlyProtocol, WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate {

    public var navBarColor:UIColor!
    public var navBarButtonColor:UIColor!
    public var navBarTitleColor:UIColor!
    public var navBarSubtitleColor:UIColor!
    private let inAppIntegrationContext = "InAppBrowser"
    private var returnHandler:TrustlyCallback?
    private var cancelHandler:TrustlyCallback?
    private var externalUrlHandler:TrustlyCallback?
    private var bankSelectedHandler:TrustlyCallback?
    private var changeListenerHandler:TrustlyListenerCallback?
    private var establishData:[AnyHashable : Any]?
    private var mainWebView:WKWebView!
    private var returnUrl = "msg://return"
    private var cancelUrl = "msg://cancel"
    private var urlScheme = ""
    private var webSession: ASWebAuthenticationSession!
    private var baseUrls = ["paywithmybank.com", "trustly.one"]
    private let oauthLoginPath = "/oauth/login/"

    
    //Constructors

    override init(frame:CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    

    func notifyListener(_ eventName:String!, _ eventDetails:[AnyHashable : Any]!) {
        if(changeListenerHandler != nil) {
            changeListenerHandler!(eventName, eventDetails)
        }
    }

    func initView() {
        self.createNotifications()
        
        self.navBarColor = Rgb2UIColor(254, 255, 254)
        self.navBarButtonColor = Rgb2UIColor(109, 109, 109)
        self.navBarTitleColor = Rgb2UIColor(0, 0, 0)
        self.navBarSubtitleColor = Rgb2UIColor(51, 51, 51)

        let configuration = WKWebViewConfiguration()
        let userController = WKUserContentController()
        userController.add(self, name: "PayWithMyBankNativeSDK")
        configuration.userContentController = userController
        
        let wkPreferences = WKPreferences()
        wkPreferences.javaScriptCanOpenWindowsAutomatically = true
        
        configuration.preferences = wkPreferences

        let frame = CGRect(x:0, y:0, width: self.frame.size.width, height: self.frame.size.height)
        mainWebView = WKWebView(frame:frame, configuration:configuration)
        mainWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainWebView.navigationDelegate = self
        mainWebView.uiDelegate = self
        mainWebView.scrollView.bounces = false
        mainWebView.backgroundColor = UIColor.clear
        mainWebView.isOpaque = false

        addSubview(mainWebView)
    }

    //TrustlySDK Protocol
    public func selectBankWidget(establishData eD:[AnyHashable : Any], onBankSelected: TrustlyCallback?) -> UIView? {
        establishData = eD
        
        var query = [String : Any]()
        var hash = [String : Any]()
        
        let deviceType = establishData?["deviceType"] ?? "mobile" + ":ios:native"
        query["deviceType"] = deviceType
        
        if let lang = establishData?["metadata.lang"] as? String {
            query["lang"] = lang
        }

        query["onlinePPSubType"] = establishData?["onlinePPSubType"]
        query["accessId"] = establishData?["accessId"]
        query["merchantId"] = establishData?["merchantId"]
        query["paymentType"] = establishData?["paymentType"] ?? "Instant"
        query["deviceType"] = deviceType
        query["grp"] = self.getGrp()
        query["dynamicWidget"] = "true"
        
        if establishData?["customer.address.country"] != nil {
            query["customer.address.country"]=establishData?["customer.address.country"]
        }
        
        if (establishData?["customer.address.country"] == nil || establishData?["customer.address.country"] as! String == "us") &&
            establishData?["customer.address.state"] != nil{
            query["customer.address.state"]=establishData?["customer.address.state"]
        }
        
        hash["merchantReference"] = establishData?["merchantReference"] ?? ""
        hash["customer.externalId"] = establishData?["customer.externalId"] ?? ""
        
        bankSelectedHandler = onBankSelected

        let url = getEndpointUrl(function: "widget", establishData:establishData as! [String : String]) + "&" + urlEncoded(query) + "#" + urlEncoded(hash)
        var request = URLRequest(url: URL(string: url)!)

        request.httpMethod = "GET"
        request.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", forHTTPHeaderField:"Accept")

        self.notifyEvent("widget", "loading")

        self.mainWebView!.tag = WidgetView
        self.mainWebView!.load(request)

        return self
    }

    public func establish(establishData eD: [AnyHashable : Any], onReturn: TrustlyCallback?, onCancel: TrustlyCallback?) -> UIView? {
        establishData = eD

        let deviceType = establishData?["deviceType"] ?? "mobile" + ":ios:native"
        establishData?["deviceType"] = deviceType
        if let lang = establishData?["metadata.lang"] as? String {
            establishData?["lang"] = lang
        }
        
        establishData?["metadata.sdkIOSVersion"] = build
        
        if establishData?.index(forKey: "metadata.integrationContext") == nil {
            establishData?["metadata.integrationContext"] = inAppIntegrationContext
        }
        
        
        returnUrl = "msg://return"
        establishData?["returnUrl"] = returnUrl
        cancelUrl = "msg://cancel"
        establishData?["cancelUrl"] = cancelUrl
        establishData?["version"] = "2"
        establishData?["grp"] = self.getGrp()

        if establishData?["paymentProviderId"] != nil {
            establishData?["widgetLoaded"] = "true"
        }
        
        if let scheme = establishData?["metadata.urlScheme"] as? String {
            self.urlScheme = scheme.components(separatedBy: ":")[0]
        }
        
        returnHandler = onReturn
        cancelHandler = onCancel
        externalUrlHandler = nil

        let url = getEndpointUrl(function: "index", establishData:establishData! as! [String:String])
        var request = URLRequest(url: URL(string: url)!)

        request.httpMethod = "POST"
        request.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", forHTTPHeaderField:"Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")

        let requestData = urlEncoded(establishData!).data(using: .utf8)

        request.setValue(String(format:"%lu", requestData!.count), forHTTPHeaderField:"Content-Length")
        request.httpBody = requestData
        
        let semaphore = DispatchSemaphore(value:0)
        
        var httpData:Data?
        var response:URLResponse?
        var error:Error?
        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            httpData = data
            response = resp
            error = err
            semaphore.signal()
        }.resume()

        semaphore.wait()
        
        if(error == nil){
            self.mainWebView?.load(httpData!, mimeType:"text/html", characterEncodingName:"UTF-8", baseURL: (response?.url)!)
        } else {
            self.cancelHandler!(self, [:])
        }
        return self
    }

    public func hybrid(url address : String, returnUrl: String, onReturn: TrustlyCallback?, cancelUrl: String, onCancel: TrustlyCallback?)  -> UIView? {
        guard let url = URL(string:address)  else {
            return self
        }
        var request = URLRequest(url: url)
        self.returnUrl = returnUrl
        self.cancelUrl = cancelUrl
        returnHandler = onReturn
        cancelHandler = onCancel
        externalUrlHandler = nil
        request.httpMethod = "GET"
        request.setValue("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", forHTTPHeaderField:"Accept")
        self.mainWebView!.load(request)
        
        return self
    }
    
    public func verify(verifyData:[AnyHashable : Any], onReturn: TrustlyCallback?, onCancel: TrustlyCallback?) -> UIView? {
        var mutableDictionary = verifyData
        mutableDictionary["paymentType"] = "Verification"
        
        return establish(establishData: mutableDictionary, onReturn:onReturn, onCancel:onCancel)
    }
    
    public func onExternalUrl(onExternalUrl: TrustlyCallback?) {
        self.externalUrlHandler = onExternalUrl
    }
    
    public func onChangeListener(onChangeListener: TrustlyListenerCallback?) {
        changeListenerHandler = onChangeListener
    }

    func notifyEvent(_ page : String, _ type : String) {
        var eventDetails = [String:String]()
        eventDetails["page"] = "widget"
        eventDetails["type"] = "load"

        self.notifyListener("event", eventDetails)
    }

    //WKUIDelegate Protocol
    
    //1: Handles new window creation (window.open)
    public func webView(_ webView: WKWebView,
                   createWebViewWith configuration: WKWebViewConfiguration,
                   for navigationAction: WKNavigationAction,
                   windowFeatures: WKWindowFeatures) -> WKWebView? {
        if(webView == mainWebView) {
            if navigationAction.targetFrame == nil, let url = navigationAction.request.url {
                self.openOAuth(url: url)
            }
            
        } else {
            //1.2: On the OAuth view opens the new window on a SFSafariViewController
            if navigationAction.targetFrame == nil, let url = navigationAction.request.url {
                presentOnSFSafariViewController(url)
            }
        }
      return nil
    }
    
    //WKUserContentController Protocol

    public func userContentController(_ userContentController:WKUserContentController, didReceive message:WKScriptMessage){
        let content = message.body as? String
        if content == nil {
            return
        }

        if message.webView == mainWebView {
            let params:[String]! = content?.components(separatedBy: "|")
            if params.count == 0 {
                return
            }

            let command = params[0]
            if command.isEqual("") {
                return
            }

            if command.isEqual("PayWithMyBank.event") {
                let eventName:String! = "event"

                var eventDetails = [String:String]()
                eventDetails["page"] = (params.count > 2 ? params[2] : "")
                eventDetails["type"] = (params.count > 5 ? params[5] : "")
                eventDetails["transactionId"] = (params.count > 3 ? params[3] : "")
                eventDetails["merchantReference"] = (params.count > 4 ? params[4] : "")

                let data:String! = (params.count > 6 ? params[6] : "")
                let transfer:String! = (params.count > 7 ? params[7] : "")

                if data.count != 0 {
                    eventDetails["data"] = data
                }

                if data.count != 0 {
                    eventDetails["transfer"] = transfer
                }

                notifyListener(eventName, eventDetails)
                
            }
        }
    }

    //WKNavigationDelegate Protocol
    
    public func webView(_ webView:WKWebView, didFinish navigation:WKNavigation!) {

        let contentSize:CGSize = webView.scrollView.contentSize
        let viewSize:CGSize = webView.bounds.size

        if viewSize.width>0 && contentSize.width>0 {
            let rw = viewSize.width / contentSize.width
            webView.scrollView.minimumZoomScale = rw
            webView.scrollView.maximumZoomScale = rw
            webView.scrollView.zoomScale = rw
        }

        if webView.tag == WidgetView {
            self.notifyEvent("widget","load")
        }

        let regex = try? NSRegularExpression(pattern: "[0-9]+", options:NSRegularExpression.Options.caseInsensitive)

        let theTitle:String! = webView.title
        
        let matches = regex!.matches(in: theTitle, options:[], range: NSMakeRange(0, theTitle.count))

        for match in matches {
            let value = Int(theTitle[Range(match.range,in: theTitle)!])! / 100
            if value == 4 || value == 5 {
                if (self.cancelHandler != nil) {
                    self.cancelHandler!(self, [:])
                }
                break
            }
         }

    }

    public func webView(webView:WKWebView!, didFailNavigation error:NSError!) {

        if webView == mainWebView {
            if (self.cancelHandler != nil) {
                self.cancelHandler!(self, [:])
            }
        }
    }

    //Handles page navigation on the WKWebView
    public func webView(_ webView:WKWebView, decidePolicyFor navigationAction:WKNavigationAction, decisionHandler:(WKNavigationActionPolicy)->Void) {
        let request = navigationAction.request
        let targetFrame = navigationAction.targetFrame;
        let host = request.url?.host
        //let relative = request.url?.relativePath ?? ""
        let query = request.url?.query ?? ""
        let scheme = request.url?.scheme ?? ""
        let absolute = request.url?.absoluteString

        if(webView == mainWebView){
            if(absolute != nil && absolute!.hasPrefix(returnUrl)){
                if returnHandler != nil {
                    returnHandler!(self, self.parametersForUrl(request.url!))
                }
                self.notifyListener("close", nil)
                decisionHandler(WKNavigationActionPolicy.cancel)
            }
            else if(absolute != nil && absolute!.hasPrefix(cancelUrl)){
                if cancelHandler != nil {
                    cancelHandler!(self, self.parametersForUrl(request.url!))
                }
                self.notifyListener("close", nil)
                decisionHandler(WKNavigationActionPolicy.cancel)
            } else if (scheme == "msg") {
                //messages
                switch(host){
                    case "push":
                        let params = self.urlDecode(query)?.components(separatedBy: "|")
                        if ("PayWithMyBank.createTransaction" == params?[0]) && bankSelectedHandler != nil {
                            if params?.count ?? 0 > 1 {
                                establishData?["paymentProviderId"] = params?[1]
                            }
                            
                            if let establishData = establishData {
                                bankSelectedHandler?(self, establishData)
                            }
                            
                        }
                        break;
                    case .none:
                        break;
                    case .some(_):
                        break;
                }
                decisionHandler(WKNavigationActionPolicy.cancel)
            } else {
                // 3: Handle external links from the main web view by opening the links on the SFSafariViewController
                if targetFrame == nil {
                    if (self.externalUrlHandler != nil) {
                        var mutableDictionary = [String:String]()
                        mutableDictionary["url"] = request.url?.absoluteString

                        self.externalUrlHandler!(self,mutableDictionary)
                    } else {
                        //Open it on the SFSafariViewController
                        presentOnSFSafariViewController(request.url)
                    }
                    decisionHandler(WKNavigationActionPolicy.cancel)
                } else {
                    decisionHandler(WKNavigationActionPolicy.allow)
                }
            }
        }

    }

    //Utility Functions
    func presentOnSFSafariViewController(_ url: URL?) {
        if url != nil {
            let vc = SFSafariViewController(url: url!)
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
              while let presentedViewController = topController.presentedViewController {
                  topController = presentedViewController
              }
              topController.present(vc, animated: true, completion: nil)
           }
        }
    }

    func getEndpointUrl(function:String, establishData:[String:String]) -> String {
        var fn = function
        let env = establishData["env"]
        let localUrl = establishData["localUrl"]
        var subDomain = ""
        var url:String

        if env != nil && env!.count > 0 {
            subDomain = String(format:"%@.", env!)
        }

        if  "index" == fn &&
            "Verification" != establishData["paymentType"] &&
            establishData["paymentType"] != nil {
            fn = "selectBank"
        }

        if ("local" == env), let urlLocal = localUrl {
            url = urlLocal+"/start/selectBank/"+fn+"?v="+build+"-ios-sdk"
            
            let cleanLocalUrl = urlLocal.components(separatedBy: ":")[0]
            self.baseUrls.append(cleanLocalUrl)
            
        } else {
            url = "https://"+subDomain+"paywithmybank.com/start/selectBank/"+fn+"?v="+build+"-ios-sdk"
        }
        return url
    }

    func parametersForUrl(_ url:URL) -> [AnyHashable : Any] {
        let absoluteString = url.absoluteString
        var queryStringDictionary = [String : String]()
        let urlComponents = url.query?.components(separatedBy: "&")

        for keyValuePair in urlComponents! {
            let pairComponents = keyValuePair.components(separatedBy: "=")
            let key = pairComponents.first?.removingPercentEncoding
            let value = pairComponents.last?.removingPercentEncoding
            queryStringDictionary[key!] = value
         }

        let regex = try! NSRegularExpression(pattern: "&requestSignature=.*", options:NSRegularExpression.Options.caseInsensitive)
        queryStringDictionary["url"] =
            regex.stringByReplacingMatches(in: absoluteString,
                                           options:[],
                                           range:NSMakeRange(0, absoluteString.count),
                                           withTemplate:"") as String

        return queryStringDictionary
    }

    func getGrp() -> String! {
        return getDefault(key: "Trustly.grp", def: generateGrp())
    }
    
    func getDefault(key:String, def: String) -> String{
        let userDefaults:UserDefaults = UserDefaults.standard
        var value = userDefaults.object(forKey: key) as? String
        if(value == nil){
            value = def
            userDefaults.set(value,forKey: key)
            userDefaults.synchronize()
        }
        return value ?? ""
    }

    func generateGrp() -> String! {
        var grp:String!
        let grpInt:Int = Int(arc4random_uniform(100))
        grp = String(format:"%d", grpInt)
        return grp
    }
    
    private func toString(_ object: Any?) -> String? {
        if let object = object {
            return "\(object)"
        }
        return nil
    }

    private func urlEncode(_ object: Any?) -> String? {
        let str = toString(object)
        let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789-._~")

        return str?.addingPercentEncoding(withAllowedCharacters: set)
    }

    private func urlDecode(_ object: Any?) -> String? {
        let string = toString(object)

        return string?.removingPercentEncoding
    }


    func urlEncoded(_ data:[AnyHashable : Any?]) -> String! {
        var parts = [String]()
        for (key,value) in data {
            let part = String(format:"%@=%@", urlEncode(key)!, urlEncode(value)!)
            parts.append(part)
         }
        return parts.joined(separator: "&")
    }

}

@available(iOS 12.0, *)
extension TrustlyView: ASWebAuthenticationPresentationContextProviding {
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

@available(iOS 12.0, *)
extension TrustlyView {
    public static let trustlyCloseWebview = "trustly.close.webView"
    
    private func openOAuth(url: URL) {
        let host = url.host!
        let path = url.path
        
        //1.1: On the main view creates a new OAuth view (new WKWebview) and opens the URL there
        if self.checkUrl(host: host) &&
            path.contains(self.oauthLoginPath) {

            self.buildASWebAuthenticationSession(url: url, callbackURL: urlScheme)

        }
    }
    
    // MARK: - Oauth autenthication
    private func buildASWebAuthenticationSession(url: URL, callbackURL: String){
        webSession = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackURL, completionHandler: { (url, error) in
            self.proceedToChooseAccount()
        })
        
        if #available(iOS 13, *) {
            webSession.prefersEphemeralWebBrowserSession = true
            webSession.presentationContextProvider = self
        }

        webSession.start()
    }
    
    private func proceedToChooseAccount(){
        self.mainWebView.evaluateJavaScript("window.Trustly.proceedToChooseAccount();", completionHandler: nil)
    }
    
    // MARK: - Utility Functions
    private func createNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(closeWebview), name: .trustlyCloseWebview, object: nil)
    }
    
    @objc func closeWebview(notification: Notification){
        if webSession != nil {
            webSession.cancel()
        }

        self.proceedToChooseAccount()
    }
    
    private func checkUrl(host: String) -> Bool {
        
        for url in self.baseUrls {
            if host.contains(url) {
                return true
            }
        }
        
        return false
    }
}

extension Notification.Name{
    @available(iOS 12.0, *)
    static let trustlyCloseWebview = Notification.Name(TrustlyView.trustlyCloseWebview)
}

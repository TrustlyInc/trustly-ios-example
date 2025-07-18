
# Implementation Notes

In the `MerchantViewController` file, you will find a controller simulating the a merchant app screen. This controller will be responsible to render the `widget` from `Trustly SDK`.

Note that the application has a URL Scheme configured in order for the app to have a Deep Link of `demoapp://`. A Deep Link is required for a successful Trustly Lightbox integration within a mobile app.

# Define Establish Data with a Request Signature

As the Trustly Lightbox SDK runs on the client, requests between it and the Trustly API must be secured. Calculate a requestSignature using your Access Key from your server and fetch it from your iOS app prior to rendering the Trustly Lightbox. For more information read the section `Define Establish Data with a Request Signature` in this [documentation](https://amer.developers.trustly.com/payments/docs/ios-quickstart#define-establish-data-with-a-request-signature), and check the code snipets bellow in the `MerchantViewController.swift` file.

```swift
        ...

        /* Uncomment the code between the lines 85 and 86 */
        showSpinner()
        self.updateEstablishWithRequestSignature()
        
        /* Comment the next line, if your merchant setup has the "Extended Security" enable in Admin console */
//        self.openLightbox()

        ...
```

```swift
    ...

    /* Uncomment this fuction if your merchant setup has the "Extended Security" enable in Admin console,
       and if did you alredy implemented in your backend the generate Request Signature endpoint.
    */
    func updateEstablishWithRequestSignature() {

        signatureApi.generateRequestSignatureFor(establishData: self.establishData) { (result) in
            do {
                try self.establishData["requestSignature"] = result.get()
                print("generateRequestSignature - requestSignature: \(self.establishData["requestSignature"])")

                self.buildLightbox()

            } catch {
                print("Error trying to get requestSignature")
            }
        }
    }

    ...
```
Also, in the file `Constants.swift`, change the variable `BASE_URL` with your backend path.
```swift
    ...

    /* Change this variable to get the requestSignature in your backend */
    static let BASE_URL = "<YOUR BACKEND URL>"

    ...
``` 

# About

This example app provides a simple integration of the Trustly Lightbox iOS SDK in a SwiftUI iOS app.

## Getting Started

- clone
- open project
- Install Trustly SDK - This can be done 2 ways
  - Cocoapods
  - Swift Package Manager

<br />

<details>
<summary>Cocoapods</summary>
<br />

TrustlySDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TrustlySDK'
```

In order to develop or test against an unreleased version of this SDK it is possible to install the pod from a branch of this repo:

```ruby
pod 'TrustlySDK', :git => 'https://github.com/TrustlyInc/trustly-ios.git', :branch => '<BRANCH_NAME>'
```

</details>

<details>
<summary>Swift Package Manager - SPM</summary>
<br />

TrustlySDK is available through [Swift Package Manager](https://www.swift.org/package-manager/). To install it from Xcode simply click on File -> Add packages -> Search or Enter Package URL, paste the github url about this package `https://github.com/TrustlyInc/trustly-ios.git`:

![Add package url](resources/swift_package_manager.png)

For production choose the `main` branch, but in order to develop or test against an unreleased version of this SDK choose the branch listed in the [release version table](#versions).

</details>
<br />

# Implementation Notes

In the `MerchantViewController` file, you will find a controller simulating the a merchant app screen. This controller will call the `TrustlyLightboxViewController` class, and this class will be responsible to call the `PayWithMyBank SDK`.

Note that the application has a URL Scheme configured in order for the app to have a Deep Link of `demoapp://`. A Deep Link is required for a successful Trustly Lightbox integration within a mobile app.

# Define Establish Data with a Request Signature

As the Trustly Lightbox SDK runs on the client, requests between it and the Trustly API must be secured. Calculate a requestSignature using your Access Key from your server and fetch it from your iOS app prior to rendering the Trustly Lightbox. For more information read the section `Define Establish Data with a Request Signature` in this [documentation](https://amer.developers.trustly.com/payments/docs/ios-quickstart#define-establish-data-with-a-request-signature), and check the code snipets bellow in the `TrustlyLightboxViewController.swift` file.

```swift
        ...

        /* Uncomment this function only if your merchant setup has the "Extended Security" enable in Admin console, and uncomment the code between the lines
        79-93 */
        self.updateEstablishWithRequestSignature()

        ...
```

```swift
    ...

    /* Uncomment this fuction if your merchant setup has the "Extended Security" enable in Admin console,
       and if did you alredy iimplemented in your backend the generate Request Signature endpoint.
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

# Server Side Features

This example project can be run entirely as a frontend app in order to quickly test basic Trustly functions. However, your application will likely require backend integration with Trustly as well. Check out our [trustly-nestjs-example](https://github.com/TrustlyInc/trustly-nestjs-example) project to learn more and follow the steps below to integrate it with this app.

# Contributing

You can participate in this project by submitting bugs and feature requests in the [Issues](https://github.com/TrustlyInc/trustly-ios-example/issues) tab. Please, add [@lukevance](https://github.com/lukevance) as an assignee.

If you are interested in fixing issues and contributing directly to the code base, feel free to open a Pull Request with your changes. Please, make sure to fulfill our [Pull Request Template](https://github.com/TrustlyInc/trustly-ios-example/blob/main/.github/pull_request_template.md) and add [@lukevance](https://github.com/lukevance) as code reviewer.

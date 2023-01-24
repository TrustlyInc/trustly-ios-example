# About this demo

This app demo has a propose to demonstrate how to implement to use the IOS SDK.


**IMPORTANT:**

If you try to run the demo after cloned, the demo will fail because you need to import the IOS SDK (PayWithMyBank SDK) first. We will go in through this steps bellow.


## Introduction

In this demo we will show how to download and import the PayWithMyBank IOS SDK to your IOS app, and how easy is to use it.

- Clone the project in your local environment;
- Open the project in your xCode. You can use the **PayWithMyBankSDKDemoIOS.xcodeproj** file;
- Download the PayWithMyBank SDK from our repository, [click here](https://repo.paywithmybank.com/Specs/paywithmybank-ios-sdk/) (choose the latest version);
- Extract the file downloaded in your local environment;
- In your xCode:
    1. Select the project;
    2. Select the target;
    3. In the `Framework, Libraries, and Embedded Content` click in `+` button;
    ![xCode](resources/xCode.png "xCode")

    4. In the opened pop-up click in `Add Other...` drop down, and click in `Add files...`;
    ![frameworks](resources/frameworks.png "frameworks")

    5. Go to the SDK directory that you extracted before and select `PayWithMyBank.xcframework`;
    ![chooseFramework](resources/chooseFramework.png "chooseFramework")

    6. If the framework shows in your project, you can build the app.
    ![frameworkImported](resources/frameworkImported.png "frameworkImported")


**IMPLEMENTATION:**

*****

In the `MerchantViewController` file, we can find a controller simulating the merchant app screen. This controller will call the `PayWithMyBankViewController` class, and this class will be responsible to call the `PayWithMyBank SDK`.

*It is important to mention that our SDK requires an url scheme configured in you app to work.*



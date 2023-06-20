//
//  TrustlySDKDemoIOSApp.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 12/06/23.
//

import SwiftUI

@main
struct TrustlySDKDemoIOSApp: App {
    var body: some Scene {
        WindowGroup {
            ProductsListView(viewModel: ProductListViewModel())
        }
    }
}

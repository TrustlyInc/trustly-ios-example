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
            NavigationStack{
                ProductsListView(viewModel: ProductViewModel())
            }
        }
    }

    init(){
        let coloredAppearance = UINavigationBarAppearance()
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance

        let image = UIImage(systemName: "chevron.backward")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        coloredAppearance.setBackIndicatorImage(image, transitionMaskImage: image)
    }
}

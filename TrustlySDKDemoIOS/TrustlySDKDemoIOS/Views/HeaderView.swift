//
//  HeaderView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 16/06/23.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading){
            Image(imageName).padding()
            Text(title)
                .font(.custom("Open Sans", size: 28.0))
                .fontWeight(.bold)
                .foregroundColor(Color.ui.mainTitle)
                .padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Checkout", imageName: "logo").previewLayout(.sizeThatFits)
    }
}

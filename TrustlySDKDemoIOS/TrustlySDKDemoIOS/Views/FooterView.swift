//
//  FooterView.swift
//  TrustlySDKDemoIOS
//
//  Created by Marcos Rivereto on 16/06/23.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Subtotal:")
                Spacer()
                Text("$90.00")
            }.padding()
            HStack{
                Text("Shipping:")
                Spacer()
                Text("Free")
            }.padding(.leading, 15)
                .padding(.trailing, 15)
            
            Divider()
            
            HStack{
                Text("Total:")
                Spacer()
                Text("$190.00")
            }.padding(.all)

        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView().previewLayout(.sizeThatFits)
    }
}

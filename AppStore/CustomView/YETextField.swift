//
//  YETextField.swift
//  AppStore
//
//  Created by Yahaya on 24/06/2023.
//

import Foundation
import SwiftUI

struct YETextField:View{
    var image: String
    var placeholder: String
    var text: Binding<String>

    var body: some View{
        HStack {
            Image( image) // Use a system image for password field
                .padding(.leading, 16)
            
            TextField(placeholder, text: text)
                .padding()
                
        }.background(.white).cornerRadius(8)
    }

}

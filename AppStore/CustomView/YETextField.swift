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
    var type: TypeTextField

    var placeholder: String
    var text: Binding<String>

    var body: some View{
        Section{
            HStack {
                Image( image) // Use a system image for password field
                    .padding(.leading, 8)
                switch type{
                case.normal:
                    TextField(placeholder, text: text)
                        .padding(8)
                case.secure:
                    SecureField(placeholder, text: text)
                        .padding(8)
                }
                
            
        }.background(.white).cornerRadius(8)
        }
    }

}
enum TypeTextField{
    case secure, normal


}

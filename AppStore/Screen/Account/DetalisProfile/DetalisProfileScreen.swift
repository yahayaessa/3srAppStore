//
//  ContentView.swift
//  AppStore
//
//  Created by Yahaya on 21/06/2023.
//

import SwiftUI

import Combine
import iPhoneNumberField
struct DetalisProfileScreen: View {
    
    @State private var username: String = UserProfileCache.get()?.name ?? ""
    @State private var email: String = UserProfileCache.get()?.email ?? ""
    @State private var phone: String = UserProfileCache.get()?.phone_number ?? ""
    
    var body: some View {
        
        GeometryReader{context in
            
            VStack {
                Text("البيانات الشخصية")
                    .font(Font.custom(appFont, size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.04, green: 0.45, blue: 0.97)).padding(.top,50)
                Form{
                    
                    YETextField(image: "Profile", type: .normal, placeholder: "اسم المستخدم", text: $username).disabled(true)
                    
                    YETextField(image: "Message", type: .normal, placeholder: "البريد الالكتروني", text: $email)
                    
                    iPhoneNumberField(text: $phone)
                        .defaultRegion("SA").prefixHidden(false).autofillPrefix(true)
                        .font(.custom(appFont, size: 30))
                    .padding(8)
                   
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: context.size.height, maxHeight: .infinity, alignment: .center).padding(.horizontal,0).background(Rectangle()
                    .foregroundColor(.clear)
                    .background(Color(red: 0.04, green: 0.45, blue: 0.97).opacity(0.1))
                    .cornerRadius(30)).scrollContentBackground(.hidden)
                
                
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
    
}


struct DetalisProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetalisProfileScreen( )
    }
}

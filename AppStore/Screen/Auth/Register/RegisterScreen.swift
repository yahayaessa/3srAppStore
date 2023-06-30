//
//  ContentView.swift
//  AppStore
//
//  Created by Yahaya on 21/06/2023.
//

import SwiftUI

import Combine

struct RegisterScreen: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            
        GeometryReader{context in
            
            VStack {
                Text("مستخدم جديد")
                    .font(Font.custom("Inter", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.04, green: 0.45, blue: 0.97)).padding(.top,50)
                
                Form{
                    
                    YETextField(image: "Profile", type: .normal, placeholder: "اسم المستخدم", text: $username)
                    
                    YETextField(image: "Message", type: .normal, placeholder: "البريد الالكتروني", text: $email)
                    
                    YETextField(image: "Call", type: .normal, placeholder: "رقم الجوال", text: $phone)
                    
                    YETextField(image: "Password", type: .secure, placeholder: "كلمة المرور", text: $password)
                    
                    YETextField(image: "Password", type: .secure, placeholder: "تأكيد كلمة المرور", text: $confirmPassword)
                    Section{
                        Button(action: {
                        }) {
                            YAButtonBackground(title: "تسجيل الدخول")
                        }
                        
                        Button(action: {
                            
                            presentationMode.wrappedValue.dismiss()
                            // Handle forgot password button action here
                        }) {
                            Text("لديك حساب؟ تسجيل الدخول")
                                .foregroundColor(.black)
                        }.frame(maxWidth: .infinity, alignment: .center)                       
                    }.listRowBackground(Color.clear).listRowSeparator(.hidden)
                    
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: context.size.height, maxHeight: .infinity, alignment: .center).padding(.horizontal,0).background(Rectangle()
                    .foregroundColor(.clear)
                    .background(Color(red: 0.04, green: 0.45, blue: 0.97).opacity(0.1))
                    .cornerRadius(30)).scrollContentBackground(.hidden)
                
            }.edgesIgnoringSafeArea(.bottom)
        }
        }
    }


struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}

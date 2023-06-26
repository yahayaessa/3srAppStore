//
//  ContentView.swift
//  AppStore
//
//  Created by Yahaya on 21/06/2023.
//

import SwiftUI


struct RegisterScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ScrollView(.vertical){
                
                HStack{
                    VStack {
                        
                        Text("تسجيل الدخول")
                            .font(Font.custom("Inter", size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.04, green: 0.45, blue: 0.97)).padding(.top,50)
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                            
                                .background(Color(red: 0.04, green: 0.45, blue: 0.97).opacity(0.1))
                                .cornerRadius(30)
                            VStack{
                                YETextField(image: "Message", placeholder: "البريد الالكتروني", text: $username).padding(.bottom, 20)
                                YETextField(image: "Message", placeholder: "البريد الالكتروني", text: $username).padding(.bottom, 20)
                                
                                YETextField(image: "Password", placeholder: "كلمة المرور", text: $password)
                                    .padding(.bottom, 20)
                                
                                Button(action: {
                                    // Handle forgot password button action here
                                }) {
                                    YAButtonBackground(title: "تسجيل الدخول")
                                }.padding(.bottom, 20)
                                
                                Button(action: {
                                    // Handle forgot password button action here
                                }) {
                                    Text("ليس لديك حساب؟ إنشاء حساب")
                                        .foregroundColor(.black)
                                }
                                
                                Spacer()
                                Button(action: {
                                    // Handle forgot password button action here
                                }) {
                                    Text("التسجيل عن طريق معرف الجهاز UUID")
                                        .foregroundColor(.black)
                                }
                                Spacer()
                                Button(action: {
                                    // Handle forgot password button action here
                                }) {
                                    Text("هل نسيت كلمة المرور؟")
                                        .foregroundColor(.black)
                                }
                                
                            }    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom).padding(.top,32).padding(.horizontal,24)
                        }.frame(height: .infinity)
                    }.frame(maxHeight: .infinity, alignment: .bottom)
                    
                }
            
        }.edgesIgnoringSafeArea(.bottom)
        
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}

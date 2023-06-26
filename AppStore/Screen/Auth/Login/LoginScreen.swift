//
//  ContentView.swift
//  AppStore
//
//  Created by Yahaya on 21/06/2023.
//

import SwiftUI


struct LoginScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("تسجيل الدخول")
              .font(Font.custom("Inter", size: 20))
              .multilineTextAlignment(.center)
              .foregroundColor(Color(red: 0.04, green: 0.45, blue: 0.97)).padding(.top,50)
            Image("Layer 1") // Replace "logo" with the name of your app's logo image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 200)
                
            
            ZStack {
                Rectangle()
                .foregroundColor(.clear)
                
                .background(Color(red: 0.04, green: 0.45, blue: 0.97).opacity(0.1))
                .cornerRadius(30)
                VStack{
                    YETextField(image: "Message", placeholder: "البريد الالكتروني", text: $username).padding(.bottom, 20)
                    
                    YETextField(image: "Password", placeholder: "كلمة المرور", text: $password)
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        // Handle forgot password button action here
                    }) {
                        YAButtonBackground(title: "تسجيل الدخول")
                    }.padding(.bottom, 20)
                    
                    NavigationLink("ليس لديك حساب؟ إنشاء حساب"){
                        RegisterScreen()
                    }
                  
                    Spacer()
                    Button(action: {
                        // Handle forgot password button action here
                    }) {
                        Text("التسجيل عن طريق معرف الجهاز UUID")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Spacer()
                    Button(action: {
                        // Handle forgot password button action here
                    }) {
                        Text("هل نسيت كلمة المرور؟")
                            .foregroundColor(.black)
                    }
                    Spacer()
                    
                }    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).padding(.top,32).padding(.horizontal,24)

               
                Spacer()
            }
        }.edgesIgnoringSafeArea(.bottom)
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

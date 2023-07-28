//
//  SplashScreen.swift
//  AppStore
//
//  Created by Yahaya on 25/07/2023.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack{
            Image("SplashHome").resizable().scaledToFill()
            VStack{
                Spacer()
                Text("متجر عصر").foregroundColor(.white).frame(maxWidth: .infinity).font(.custom(appFont, size: 23)).padding(16)
                Text("متجر عصر لتطبيقات البلس والخدمات الرقمية  اكثر من 10 سنوات في مجال التطبيقات والخدمات الرقميه   موثوق لدى المركز السعودي للاعمال").foregroundColor(.white).multilineTextAlignment(.leading).font(.custom(appFont, size: 20)).padding(.horizontal,20)
                HStack{
                    NavigationLink {
                        LoginScreen().environmentObject(AuthViewModel())
                    } label: {
                        YAButtonBackground(title: "تسجيل الدخول").frame(height: 55)
                    }
                    NavigationLink {
                        RegisterScreen().environmentObject(AuthViewModel())
                    } label: {
                        YAButtonBackground(title: "مستخدم جديد").frame(height: 55)
                    }

                }.padding(.horizontal,16)
                Button{
                    skip()
                }label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            Color.gray.opacity(0.5)
                        )
                        .cornerRadius(14).overlay(
                            Text("تخطي").foregroundColor(.white).font(.custom(appFont, size: 18))
                        ).frame(maxHeight: 55).padding(.bottom,80).padding(.horizontal,16)
                }
                
                
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

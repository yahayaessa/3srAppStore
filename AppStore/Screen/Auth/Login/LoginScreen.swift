//
//  ContentView.swift
//  AppStore
//
//  Created by Yahaya on 21/06/2023.
//

import SwiftUI


struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        GeometryReader{context in
            VStack {
                Text("تسجيل الدخول")
                    .font(Font.custom("Inter", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.04, green: 0.45, blue: 0.97)).padding(.top,50)
                
                Image("Layer 1") // Replace "logo" with the name of your app's logo image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 200)
                
                Form{
                    YETextField(image: "Message", type: .normal, placeholder: "البريد الالكتروني", text: $email)
                    YETextField(image: "Password", type: .secure, placeholder: "كلمة المرور", text: $password)

                    Section{
                        ZStack(alignment: .leading) {
                            YAButtonBackground(title: "تسجيل الدخول")
                                NavigationLink(destination: TabBarView(selected: .home).navigationBarHidden(true).environment(\.layoutDirection, .rightToLeft)) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                            }                       
                        NavigationLink{
                            RegisterScreen().navigationBarHidden(true)                    .environment(\.layoutDirection, .rightToLeft)

                        }label:{
                            Text("ليس لديك حساب؟ إنشاء حساب"
                            ).frame(minWidth: context.size.width)}
                        Button(action: {
                        }) {
                            Text("التسجيل عن طريق معرف الجهاز UUID")
                                .foregroundColor(.black)
                        }.frame(minWidth: context.size.width)
                        Button(action: {
                            // Handle forgot password button action here
                        }) {
                            Text("هل نسيت كلمة المرور؟")
                                .foregroundColor(.black)
                        }.frame(minWidth: context.size.width)
                    }.listRowBackground(Color.clear).listRowSeparator(.hidden)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: context.size.height, maxHeight: .infinity, alignment: .center).padding(.horizontal,0).background(Rectangle()
                    .foregroundColor(.clear)
                    .background(Color(red: 0.04, green: 0.45, blue: 0.97).opacity(0.1))
                    .cornerRadius(30)).scrollContentBackground(.hidden).edgesIgnoringSafeArea(.bottom)
                
            }
        }
    }
}
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

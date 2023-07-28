//
//  ContentView.swift
//  AppStore
//
//  Created by Yahaya on 21/06/2023.
//

import SwiftUI

import Combine
import iPhoneNumberField
struct RegisterScreen: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject  var authViewModel: AuthViewModel
    @State var inProgress = false // <--- here

    
    var body: some View {
        
        GeometryReader{context in
            
            VStack {
                Text("مستخدم جديد")
                    .font(Font.custom(appFont, size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.04, green: 0.45, blue: 0.97)).padding(.top,50)
                Form{
                    
                    YETextField(image: "Profile", type: .normal, placeholder: "اسم المستخدم", text: $username)
                    
                    YETextField(image: "Message", type: .normal, placeholder: "البريد الالكتروني", text: $email)
                    
                    iPhoneNumberField(text: $phone)
                        .defaultRegion("SA").prefixHidden(false).autofillPrefix(true)
                        .font(.custom(appFont, size: 30))
                    .padding(8)
//                    YETextField(image: "Call", type: .normal, placeholder: "رقم الجوال", text: $phone)
                    
                    YETextField(image: "Password", type: .secure, placeholder: "كلمة المرور", text: $password)
                    
                    YETextField(image: "Password", type: .secure, placeholder: "تأكيد كلمة المرور", text: $confirmPassword)
                    Section{
                        Button(action: {
                            inProgress.toggle()
                            registerAction()
                        }) {
                            if inProgress {
                                HStack(alignment: .center){
                                    Spacer()
                                        ProgressView()
                                    Spacer()
                                }
                            }else{
                                YAButtonBackground(title: "تسجيل الدخول").frame(height: context.size.height / 14).frame(minWidth: context.size.width/1.1)
                            }
                        }
//                        Button(action: {
//                            presentationMode.wrappedValue.dismiss()
//                            // Handle forgot password button action here
//                        }) {
//                            Text("لديك حساب؟ تسجيل الدخول").font(.custom(appFont, size: 18))
//                                .foregroundColor(.black)
//                        }.frame(maxWidth: .infinity, alignment: .center)
                    }.listRowBackground(Color.clear).listRowSeparator(.hidden)
                    
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: context.size.height, maxHeight: .infinity, alignment: .center).padding(.horizontal,0).background(Rectangle()
                    .foregroundColor(.clear)
                    .background(Color(red: 0.04, green: 0.45, blue: 0.97).opacity(0.1))
                    .cornerRadius(30)).scrollContentBackground(.hidden)
                
                
            }.edgesIgnoringSafeArea(.bottom)
        }.alert(authViewModel.error ?? "", isPresented: $authViewModel.isError) {
            Button("حسنا", role: .cancel) { }
        }
    }
    private func registerAction() {
        self.authViewModel.register(email: email, username: username, phone: phone, password: confirmPassword, password_confirmation: confirmPassword, completeBlock: { isSccess in
            inProgress.toggle()
            if isSccess{
                goToMainView()
            }
            
        })
     }
}


struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen( ).environmentObject(AuthViewModel())
    }
}

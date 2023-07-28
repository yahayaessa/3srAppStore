//
//  ContentView.swift
//  AppStore
//
//  Created by Yahaya on 21/06/2023.
//

import SwiftUI
import iPhoneNumberField


struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject  var authViewModel: AuthViewModel
    @State var inProgress = false // <--- here
    @State var loginUsePhoneNumber = 0 // <--- here

    var body: some View {
        GeometryReader{context in
            ZStack {
                VStack {
                    Text("تسجيل الدخول")
                        .font(Font.custom(appFont, size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.04, green: 0.45, blue: 0.97)).padding(.top,50)
                    
                    Image("Layer 1") // Replace "logo" with the name of your app's
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 200)
                    
                    Form{
                        Picker( "", selection: $loginUsePhoneNumber) {
                            Text("رقم الجوال").tag(0)
                            Text("البريد الإلكتروني").tag(1)
                        }.pickerStyle(.segmented).listRowSeparator(.hidden).listRowBackground(Color.clear)
                        if loginUsePhoneNumber == 0{
                            Section{
                                iPhoneNumberField(text: $authViewModel.phoneNumber)
                                    .defaultRegion("SA").prefixHidden(false).autofillPrefix(true)
                                    .font(.custom(appFont, size: 30))
                                .padding(8)}
                        }else{
                            YETextField(image: "Message", type: .normal, placeholder: "البريد الالكتروني", text: $email)
                            YETextField(image: "Password", type: .secure, placeholder: "كلمة المرور", text: $password)
                        }
                        Section{
                            
                            Button {
                                inProgress.toggle()
                                if loginUsePhoneNumber == 0{
                                    loginPhoneAction()
                                }else{
                                    loginAction()
                                }
                            } label: {
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
                            
                            //                        NavigationLink{
                            //                            RegisterScreen().environmentObject(AuthViewModel()).navigationBarHidden(true)                    .environment(\.layoutDirection, .rightToLeft)
                            //
                            //                        }label:{
                            //                            Text("ليس لديك حساب؟ إنشاء حساب"
                            //                            ).frame(minWidth: context.size.width).font(.custom(appFont, size: 18))}
                            //
                            //                        Button(action: {
                            //                            skip()
                            //                        }) {
                            //                            Text("تخطي").font(.custom(appFont, size: 18))
                            //                                .foregroundColor(.black)
                            //                        }.frame(minWidth: context.size.width)
                        }.listRowBackground(Color.clear).listRowSeparator(.hidden)
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: context.size.height, maxHeight: .infinity, alignment: .center).padding(.horizontal,0).background(Rectangle()
                        .foregroundColor(.clear)
                        .background(Color(red: 0.04, green: 0.45, blue: 0.97).opacity(0.1))
                        .cornerRadius(30)).scrollContentBackground(.hidden).edgesIgnoringSafeArea(.bottom)
                    
                }.blur(radius: authViewModel.isLoading || authViewModel.isVerify || authViewModel.isVerified ? 20 : 0)

                Verification(viewModel: authViewModel)
                    .opacity(authViewModel.isVerify ? 1 : 0)
                    .scaleEffect(CGSize(width: authViewModel.isVerify ? 1 : 0, height: authViewModel.isVerify ? 1 : 0), anchor: .center)
                    .animation(.interpolatingSpring(stiffness: 200, damping: 10, initialVelocity: 5))
            }
        }.alert(authViewModel.error ?? "", isPresented: $authViewModel.isError) {
            Button("حسنا", role: .cancel) { }
        }
    }
    private func loginAction() {
        self.authViewModel.login(email: email, password: password, completeBlock: { isSccess in
            inProgress.toggle()
            if isSccess{
                goToMainView()
            }
            
        })
     }
    private func loginPhoneAction() {
        self.authViewModel.login(phone: authViewModel.phoneNumber){ isSccess in
            inProgress.toggle()
            if isSccess{
               
            }
        }
     }
}
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().environmentObject(AuthViewModel())
    }
}

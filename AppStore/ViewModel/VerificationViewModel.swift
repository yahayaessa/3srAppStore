//
//  VerificationViewModel.swift
//  AppStore
//
//  Created by Yahaya on 27/07/2023.
//

import Foundation
import Firebase
import SwiftUI

class VerificationViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isLoadingVerify: Bool = false

    @Published var phoneNumber: String = ""
    @Published var isVerify: Bool = false
    @Published var isVerified: Bool = false
    
    @Published var isError: Bool = false
    @Published var errorMsg: String = ""
}

extension VerificationViewModel {
    
    func sendCode() {
        
        self.isLoading.toggle()
        
//        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationId, error) in
//
//            self.isLoading.toggle()
//
//            if error != nil {
//                self.isError.toggle()
//                self.errorMsg = error?.localizedDescription ?? ""
//                return
//            }
//
//            UserDefaults.standard.set(verificationId, forKey: "verificationId")
//            self.isVerify.toggle()
//        }
    }
    
    func verifyCode(code: String) {
        
        self.isLoadingVerify.toggle()
        
//        let verificationId = UserDefaults.standard.string(forKey: "verificationId") ?? ""
//        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
//
//        Auth.auth().signIn(with: credentials) { (authResult, error) in
//
//            self.isLoadingVerify.toggle()
//
//            if error != nil {
//                self.isError.toggle()
//                self.errorMsg = error?.localizedDescription ?? ""
//                return
//            }
//
//            print(authResult ?? "")
//            self.isVerify.toggle()
//            self.isVerified.toggle()
//        }
        
    }
}

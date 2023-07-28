//
//  AuthViewModel.swift
//  AppStore
//
//  Created by Yahaya on 05/07/2023.
//

import Foundation
import Combine

final class AuthViewModel : ObservableObject {
    @Published var user:User?
    @Published var error:String?
    @Published var message:String?
    @Published var isError:Bool = false

    @Published var isLoading: Bool = false
    @Published var isLoadingVerify: Bool = false

    @Published var phoneNumber: String = ""
    @Published var isVerify: Bool = false
    @Published var isVerified: Bool = false
    @Published var isAuth:Bool = false

    @Published var errorMsg: String = ""
    
    func login(email:String,password:String, completeBlock: @escaping ((Bool)->())){
        APIContentRepositoryType<MyService,User>(MyService.login(email: email, password: password)).requestContent { result in
            do{
                self.user = try result.get()
                UserProfileCache.save(self.user)
                self.isError = false
                
                completeBlock(true)
            }catch{
                self.isError = true
                self.error = error.localizedDescription
                print(error)
                completeBlock(false)
            }
            
        }
    }
    func login(phone:String, completeBlock: @escaping ((Bool)->())){
        self.isLoading.toggle()

        APIContentRepositoryType<MyService,Success>(MyService.loginPhone(number: phone, code: nil)).requestContent { result in
            self.isLoading.toggle()
            do{
//                self.message = try result.get().success
                self.isVerify.toggle()
                completeBlock(true)
            }catch{
                self.isError.toggle()
                self.error = error.localizedDescription
                print(error)
                completeBlock(false)
            }
            
        }
    }
    func login(phone:String,code:String, completeBlock: @escaping ((Bool)->())){
        self.isLoadingVerify.toggle()
        APIContentRepositoryType<MyService,User>(MyService.loginPhone(number: phone, code: code)).requestContent { result in
            self.isLoadingVerify.toggle()
            do{
                self.user = try result.get()
                UserProfileCache.save(self.user)
                self.isVerify.toggle()
                self.isVerified.toggle()
                completeBlock(true)
            }catch{
                self.isError = true
                self.error = error.localizedDescription
                print(error)
                completeBlock(false)
            }
            
        }
    }
    func register(email:String,username:String,phone:String,password:String,password_confirmation:String, completeBlock: @escaping ((Bool)->())){
        APIContentRepositoryType<MyService,User>(MyService.register(email: email, username: username, phone: phone, password: password,password_confirmation:password_confirmation)).requestContent { result in
            
            do{
                self.user = try result.get()
                UserProfileCache.save(self.user)
                self.isError = false
                completeBlock(true)
            }catch{
                self.isError = true
                self.error = error.localizedDescription
                print(self.error)
                completeBlock(false)
            }
            
        }
    }
    func profile(){
        APIContentRepositoryType<MyService,User>(MyService.profile).requestContent { result in
            do{
                UserProfileCache.save(try result.get())
                self.loginUDID()
            }catch{
                let errorAPI = error as? APIError
                if errorAPI?.code == 403{
                    self.isAuth.toggle()
                    print("unauth")
                }
                self.error = error.localizedDescription
                print(error)
            }
            
        }
    }
    func loginUDID(){
        
        APIContentRepositoryType<MyService,LoginUDID>(MyService.loginUDID(UserProfileCache.get()?.device_udid ?? "")).requestContent { result in
            do{
                print(try result.get())
                AppTokenCache.save(try result.get().token)
            }catch{
                self.error = error.localizedDescription
            }
            
        }
    }
    func verifyEmail(){
        APIContentRepositoryType<MyService,Success>(MyService.emailVerification).requestContent { result in
            do{
                print(try result.get())
            }catch{
                self.error = error.localizedDescription
            }
            
        }
    }
}

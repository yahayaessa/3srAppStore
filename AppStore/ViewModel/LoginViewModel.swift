//
//  LoginViewModel.swift
//  fiverr
//
//  Created by Badrshammry on 07/08/2022.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var login: LoginModel = LoginModel(token: "", userData: UserData(name: "", group: ""))

    //"00008101-000918523E2A001E" "00008030-00092CDE0EDA802E"
    func getUser(userUID: String = "") {
        print("get user...")
        print(userUID)
        guard let url = URL(string: "https://v2.3sr0store.com/api/ipastore/device/login?device_udid=" + userUID) else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        print(url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        print(data)
                        let decodedUsers = try JSONDecoder().decode(LoginModel.self, from: data)
                        print("user :", decodedUsers.token)
                        self.login = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            } else {
                print("Login : 422 Error")
                self.login = LoginModel(token: "error", userData: UserData(name: "error", group: "error"))
            }
        }

        dataTask.resume()
    }
    
}

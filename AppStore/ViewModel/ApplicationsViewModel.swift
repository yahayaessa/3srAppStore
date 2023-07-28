//
//  ApplicationsViewModel.swift
//  fiverr
//
//  Created by Badrshammry on 07/08/2022.
//

import Foundation
import Combine

class ApplicationsViewModel : ObservableObject {

    @Published var items = [Application]()
      private var page = 1
      let limit: Int = 10
      private var subscriptions = Set<AnyCancellable>()
     @Published var isLoading: Bool = false

      @Published var state: State = .good {
          didSet {
              print("state changed to: \(state)")
          }
      }
    @Published var app:String = ""
    func getApplications() {
//        guard state == State.good else {
//                  return
//              }
        isLoading = true
        APIContentRepositoryType<MyService,[Application]>(MyService.applications(page)).requestContent { result in
            do{
                    self.items += try result.get()
                    self.page += 1
                    print("fetched \(try result.get().count)")
            }catch{
                self.state = .error("Could not get data: \(error.localizedDescription)")
                print(error.localizedDescription)
            }
            self.isLoading = false
        }
      
    }

    func getApp(url:String, completed:(@escaping ()->())) {
        state = .isLoading
        APIContentRepositoryType<MyService,AppDwonloadLink>(MyService.getPlistApp(url)).requestContent { result in
            do{
                self.app = try result.get().plist_url
                 print("fetched \(try result.get())")
                self.state =  !self.app.isEmpty ? .loadedAll:.error("Null")

            }catch{
                self.state = .error(error.localizedDescription)
                print(error.localizedDescription)
            }
            completed()
        }
      
    }
    func loadMore() {
        getApplications()
    }
    enum State: Comparable {
         case good
         case isLoading
         case loadedAll
         case error(String)
     }
}
struct AppDwonloadLink: Codable { var plist_url: String}

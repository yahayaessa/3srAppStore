//
//  CategoryViewModel.swift
//  AppStore
//
//  Created by Yahaya on 03/07/2023.
//

import Foundation

class OrderViewModel : ObservableObject {
    @Published var orders:[Order] = []
    @Published var isLoading = false
    @Published var selectedOrder:Order? = nil
    @Published var isClick = false

    
    func getOrders(){
        isLoading.toggle()
        APIContentRepositoryType<MyService,[Order]>(MyService.purchases).requestContent { result in
            self.isLoading.toggle()
            do{
                self.orders = try result.get()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

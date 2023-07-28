//
//  ProductsViewModel.swift
//  AppStore
//
//  Created by Yahaya on 04/07/2023.
//

import Foundation

class ProductsViewModel : ObservableObject {
    @Published var products = [Product]()
    @Published var featuredProducts = [Product]()

    var category:Category?
    @Published var searchText:String = ""
    @Published var isLoading:Bool = false

    
        init(category:Category?) {
        self.category = category
    }
    
    func getSearchProducts(){
        isLoading = true
        APIContentRepositoryType<MyService,[Product]>(MyService.searchProducts(q: searchText)).requestContent { result in
            do{
                self.products = try result.get()
            }catch{
                print(error.localizedDescription)
            }
            self.isLoading = false
        }
    }
    func getProducts(){
        isLoading = true
        APIContentRepositoryType<MyService,[Product]>(MyService.products(id: self.category!.id)).requestContent { result in
            do{
                self.products = try result.get()
            }catch{
                print(error.localizedDescription)
            }
            self.isLoading = false
        }
    }
    
}

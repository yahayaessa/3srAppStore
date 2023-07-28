//
//  CategoryViewModel.swift
//  AppStore
//
//  Created by Yahaya on 03/07/2023.
//

import Foundation

class CategoryViewModel : ObservableObject {
    @Published var categories = [Category]()
    
    
    func getCategories(){
        APIContentRepositoryType<MyService,[Category]>(MyService.categories).requestContent { result in
            do{
                self.categories = try result.get()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

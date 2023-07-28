//
//  HomeViewModel.swift
//  AppStore
//
//  Created by Yahaya on 03/07/2023.
//

import Foundation
import SwiftUI
final class HomeViewModel : ObservableObject {
    
    @Published var sliders = [Slider]()
    @Published var featuredProducts = [Product]()

    
    func getSlider(){
        APIContentRepositoryType<MyService,[Slider]>(MyService.slider).requestContent { result in
            do{
                self.sliders = try result.get()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    func getFeaturedProducts(){
        APIContentRepositoryType<MyService,[Product]>(MyService.featuredProducts).requestContent { result in
            do{
                self.featuredProducts = try result.get()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

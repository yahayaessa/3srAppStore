//
//  Categories.swift
//  AppStore
//
//  Created by Yahaya on 26/06/2023.
//

import SwiftUI

struct HomeScreen: View {
    private let images = ["slide","slide","slide"]
     var categories = [Category(id: 0, title: "asdasd", image: "asdas"),Category(id: 1, title: "asdasd", image: "asdas")]

    var body: some View {
            ScrollView{
               
                VStack {
                    GeometryReader { geometry in
                        ImageCarouselView(numberOfImages: images.count) {
                            
                            ForEach(images, id: \.self) { image in
                                Image(image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                            }
                            
                        }
                    }.frame(height: 300, alignment: .center).padding(16)
                    CategoryRow(categoryName: "التصنيفات", items: categories)
                    
                    .listRowInsets(EdgeInsets())
                }
            }.background()
        }
    }

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

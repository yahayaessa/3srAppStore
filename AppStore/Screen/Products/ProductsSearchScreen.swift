//
//  Categories.swift
//  AppStore
//
//  Created by Yahaya on 26/06/2023.
//

import SwiftUI
import ScalingHeaderScrollView

struct ProductsSearchScreen: View {
    @EnvironmentObject var products: ProductsViewModel
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var productsList: [Product] {
        if products.searchText.isEmpty {
                return products.products
            } else {
                return products.products.filter { $0.title.contains(products.searchText) }
            }
        }
    
    var body: some View {
        GeometryReader{context in
            if products.products.count > 0{
            ScrollView{
                LazyVGrid(columns: gridItemLayout) {
                    ForEach( productsList) { item in
//                        ZStack {
                            NavigationLink {
                                ProductDetailsScreen(product: $products.products[getIndex(item:item)])
                            } label: {
                                ProductItem(product: item)
                            }.buttonStyle(.plain)
//                        }.listRowSeparator(.hidden).padding(12)
                    }
                }
            }
        }else{
            ProgressView() {
                Text("تحميل")
            }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
        }
        }.searchable(text: $products.searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: "بحث").navigationBarTitleDisplayMode(.large).onAppear{
            if products.category != nil{
                products.getProducts()
            }else{
                products.getSearchProducts()
            }
        } .toolbar {
            
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("الرئيسية")
                        .font(.custom(appFont, size: 20))
                        .foregroundColor(Color.black)
                }
            }
            
        }
        
        }
                
                
            

        
    func getIndex(item: Product) -> Int {
        return productsList.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }
    
    
    
}

struct ProductsSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductsSearchScreen().environmentObject(ProductsViewModel(category: nil))
    }
}

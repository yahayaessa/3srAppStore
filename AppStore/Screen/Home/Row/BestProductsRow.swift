/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a scrollable list of landmarks.
*/

import SwiftUI

struct BestProductsRow: View {
    @EnvironmentObject var viewModel: HomeViewModel

    
    var body: some View {
            VStack(alignment: .leading) {
                Text("منتجات مميزة")
                    .font(.custom(appFont, size: 20))
                    .padding(.horizontal, 20)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 16) {
                        ForEach(viewModel.featuredProducts) { item in
                            NavigationLink {
                                ProductDetailsScreen(product: $viewModel.featuredProducts[getIndex(item: item)])
                            } label: {
                                ProductItem(product: item).frame(width: 140,height: 180)
                                                         }

                        }
                    }.padding(.leading,20)
                }
                
            
        }
        
    }
    
    func getIndex(item: Product) -> Int {
        return viewModel.featuredProducts.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }
}

struct BestProductsRow_Previews: PreviewProvider {
    static var categories:[Product] = []

    static var previews: some View {
        BestProductsRow().environmentObject(ProductsViewModel(category: Category(id: 1, title: "")))

    }
}

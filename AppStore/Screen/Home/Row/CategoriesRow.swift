/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a scrollable list of landmarks.
*/

import SwiftUI

struct CategoriesRow: View {
    var categoryName: String
    var items: [Category]

    var body: some View {
            VStack(alignment: .leading) {
                Text(categoryName)
                    .font(.custom(appFont, size: 20))
                    .padding(.horizontal, 20)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 16) {
                        ForEach(items) { item in
                            NavigationLink {
                                ProductsScreen().environmentObject(ProductsViewModel(category: item))
                            } label: {
                                CategoryItem(category: item).frame(width: 140,height: 180)
                            }

                        }
                    }.padding(.leading,20)
                }
                
            
        }
        
    }
}

struct CategoriesRow_Previews: PreviewProvider {
    static var categories = [Category(id: 0, title: "asdasd", icon: "asdas"),Category(id: 1, title: "asdasd", icon: "asdas")]

    static var previews: some View {
        CategoriesRow(
            categoryName: "التصنيفات",
            items: categories)
        
    }
}

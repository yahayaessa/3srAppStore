/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a scrollable list of landmarks.
*/

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Category]

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { item in
                        NavigationLink {
                            CategoryItem(category: item)
                        } label: {
                            CategoryItem(category: item)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var categories = [Category(id: 0, title: "asdasd", image: "asdas"),Category(id: 1, title: "asdasd", image: "asdas")]

    static var previews: some View {
        CategoryRow(
            categoryName: "التصنيفات",
            items: categories)
        
    }
}

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a scrollable list of landmarks.
*/

import SwiftUI

struct CategoryItem: View {
  
    var category:Category
    var body: some View {
        VStack(alignment: .leading) {
//            Image(systemName: "", variableValue: <#T##Double?#>)
            Text("categoryName")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

        }
    }
}

struct CategoryItem_Previews: PreviewProvider {

    static var previews: some View {
        let cat = Category(id: 5, title: "", image: "")
        CategoryItem(category: cat)
    }
}

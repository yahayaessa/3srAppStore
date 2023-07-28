/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a scrollable list of landmarks.
*/

import SwiftUI

struct CategoryItem: View {
  
    var category:Category
    var body: some View {
            VStack {
                AsyncImage(url: URL(string: category.icon ?? "")) { image in
                        image
                            .resizable()
                            .imageScale(.medium)
                    } placeholder: {
                        ZStack{
                            Color.gray.opacity(0.3)
//                            ProgressView()
                        }
                    }
                
                Text(category.title)
                    .font(.custom(appFont, size: 14))
                    .padding(.bottom, 8)

            }.overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.blue, lineWidth: 0.15)
            ).cornerRadius(7)
        
        
    }
}

struct CategoryItem_Previews: PreviewProvider {

    static var previews: some View {
        let cat = Category(id: 5, title: "", icon: "")
        CategoryItem(category: cat)
    }
}

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a scrollable list of landmarks.
*/

import SwiftUI
import CachedAsyncImage

struct ProductItem: View {
  
    var product:Product
    var body: some View {
            VStack {
                CachedAsyncImage(url: URL(string: product.icon ?? "")) { image in
                        image
                        .resizable().scaledToFit().clipped()
                    } placeholder: {
                        ZStack{
                            Color.gray.opacity(0.3)
                        }
                    }
                
                Text(product.title)
                    .font(.custom(appFont, size: 14))
                    .padding(.bottom, 8)

            }.overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.blue, lineWidth: 0.15)
            ).cornerRadius(7)
        
        
    }
}

struct ProductItem_Previews: PreviewProvider {

    static var previews: some View {
        let cat = Product(id: 0, category_id: 0, visitors: 0, sort: 0, title: "", icon: "", description: "", price: "", product_type: "", delivery_time: "", show_in_home: "")
        ProductItem(product: cat)
    }
}

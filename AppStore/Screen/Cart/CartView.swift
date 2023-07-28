//
//  CartView.swift
//  Cart
//
//  Created by RJ Hrabowskie on 10/27/20.
//

import SwiftUI
import WebKit
struct CartView: View {
    @StateObject var cartData = CartViewModel()
    @State var isError = false
    @State var errorMessage:String = ""
    @Environment(\.openURL) var openURL
    @State var isShowingWebView = false

    
    var body: some View {
        VStack {
           
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(cartData.items){ item in
                        // ItemView
                        ItemView(item: $cartData.items[getIndex(item: item)], items: $cartData.items)
                    }
                }
            }
            
            // Bottom View
            VStack {
                HStack {
                    Text("المجموع")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // Calculating Total Price
                    Text(calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding([.top, .horizontal])
                if !cartData.items.isEmpty{
                    Button(action: {
                        cartData.endOrder { isSuccess,message in
                            if isSuccess{
                                isShowingWebView.toggle()
                            }else{
                                self.errorMessage = message ?? ""
                                isError.toggle()
                            }
                        }
                    }) {
                        YAButtonBackground(title: "اتمام الطلب")
                    }.padding(10).frame(height: 70)
                }
            }
        }.alert(errorMessage, isPresented: $isError, actions: {
            
        }).sheet(isPresented: $isShowingWebView) {
            WebView(url: URL(string: cartData.invoiceURL ?? "")!)
                               .ignoresSafeArea()
                               .navigationTitle("Payment")
                               .navigationBarTitleDisplayMode(.inline)
        }.toolbar{
            ToolbarItem(placement: .principal) {
                            VStack {
                                Text("السلة")
                                  .font(.custom(appFont, size: 20))
                                  .foregroundColor(Color.black)
                            }
                        }
        }
        .background(Color("gray").ignoresSafeArea())
    }
    
    func getIndex(item: Product) -> Int {
        return cartData.items.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }
    
    func calculateTotalPrice() -> String {
        var price: Float = 0
        
        cartData.items.forEach { (item) in
            price += Float(item.quantity ?? 1) * (Float(item.price ?? "0.0") ?? 0)
        }
        
        return getPrice(value: price)
    }
}
struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        CartView().environmentObject(CartViewModel())
    }
}


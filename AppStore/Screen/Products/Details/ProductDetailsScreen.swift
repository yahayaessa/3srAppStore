//
//  ProductDetailsScreen.swift
//  AppStore
//
//  Created by Yahaya on 05/07/2023.
//

import Foundation
import SwiftUI

struct ProductDetailsScreen: View {
    @State private var showingSheet = false
    @State private var isShowingCart = false


    @Binding var product:Product
    var body: some View {
        

        GeometryReader { proxy in
            
            VStack {
                Spacer()
                VStack{
                    HStack{
                        Text(product.title)
                            .font(.custom(appFont, size: 18))
                            .padding(.bottom, 8)
                        Spacer()
                        Text("\(product.price ?? "0") SAR")
                            .font(.custom(appFont, size: 20))
                            .padding(.bottom, 8)
                    }.padding(16).padding(.top,50)
                    HStack{
                        Text("مدة التسليم")
                            .font(.custom(appFont, size: 16))
                            .padding(.bottom, 8)
                        Spacer()
                        Text(product.delivery_time ?? "")
                            .font(.custom(appFont, size: 16))
                            .padding(.bottom, 8)
                    }.padding(16)
                    HStack{
                        HStack(spacing: 15) {
                            
                            Text(getPrice(value: (Float(product.price ?? "0.0") ?? 0.0) * (Float(product.quantity ?? 1))))
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                            
                            // Add - Subtract Button
                            Button(action: {
                                if product.quantity ?? 0 > 1 { self.product.quantity! -= 1 }
                                
                            }) {
                                Image(systemName: "minus")
                                    .font(.system(size: 16, weight: .heavy))
                                    .foregroundColor(.black)
                            }
                            
                            Text("\(product.quantity ?? 1)")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color.black.opacity(0.06))
                            
                            Button(action: {
                                if var q = product.quantity{
                                    product.quantity = q+1
                                }else{
                                    self.product.quantity = 2
                                }
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .heavy))
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding(16)
                    Button {
                        CartCache.saveCart(product: product)
                        print(CartCache.loadPlaces().products)
                        showingSheet.toggle()
                    } label: {
                        YAButtonBackground(title: "اضافة الى السلة").frame(height: 55)
                    }.padding(30)
                    
                }.background(Color.white).cornerRadius(32)
                NavigationLink(destination: CartView(), isActive: $isShowingCart) { }

            }.background(
                AsyncImage(url: URL(string: product.icon ?? "")) { image in
                    image
                        .resizable().scaledToFit().padding(.bottom,proxy.size.height/2.3).background(Color.blue.opacity(0.5).blur(radius: 40))
                } placeholder: {
                    ZStack{
                        Color.gray.opacity(0.3)
                    }
                }
                
                
            ).edgesIgnoringSafeArea(.all).toolbarTitleMenu {
                Text("تفاصيل المنتج")
                    .font(.custom(appFont, size: 18))
                    .padding(.bottom, 8)
            }.toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image("Group-11613")
                    }
                }
                
                
            }
            
        }.alert(isPresented: $showingSheet) {
            Alert(title: Text("تمت الاضافة الى السلة"), primaryButton: .destructive(Text("الى السلة"), action: {
                isShowingCart.toggle()
            }), secondaryButton: .cancel(Text("متابعة التسوق")))
        }
    }
}

//struct ProductDetailsScreen_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let cat = Product(id: 0, category_id: 0, visitors: 0, sort: 0, title: "Product Name", icon: "https://3sr-site.fra1.digitaloceanspaces.com/attachments/8b9/1td/c80/8b91tdc807f8yszpjrfifi3dn.jpeg", description: "", price: "122", product_type: "", delivery_time: "", show_in_home: "")
////        ProductDetailsScreen(product: cat)
//    }
//}

//
//  ItemView.swift
//  Cart
//
//  Created by RJ Hrabowskie on 10/27/20.
//

import SwiftUI

struct ItemView: View {
    // For realtime updates
    @Binding var item: Product
    @Binding var items: [Product]
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [Color("lightblue"), Color("blue")]), startPoint: .leading, endPoint: .trailing)
            
            // Delete Button
            
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn){deleteItem()}
                }) {
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 50)
                }
            }
            
            HStack(spacing: 15) {
                AsyncImage(url: URL(string: item.icon ?? "")){image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 130, height: 130)
                        .cornerRadius(15)
                }placeholder: {
                    Color.gray.opacity(0.3)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(html: item.description ?? "",fontFamily: appFont)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray).lineLimit(1)
                    
                    HStack(spacing: 15) {
                        
                        Text(getPrice(value: Float(item.price ?? "0.0") ?? 0.0))
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                        
                        // Add - Subtract Button
                        Button(action: {
                            if item.quantity ?? 0 > 1 { item.quantity! -= 1 }
                            CartCache.updatePrice(product: item)
                        }) {
                            Image(systemName: "minus")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.black)
                        }
                        
                        Text("\(item.quantity ?? 1)")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.black.opacity(0.06))
                        
                        Button(action: {
                            if let q = item.quantity{
                                item.quantity = q+1
                            }else{
                                item.quantity = 1
                            }
                            CartCache.updatePrice(product: item)
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding()
            .background(Color("gray"))
            .contentShape(Rectangle())
            .offset(x: item.offset ?? 0.0)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            if item.isSwiped ?? false {
                item.offset = value.translation.width - 90
            } else {
                item.offset = value.translation.width
            }
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                if -value.translation.width > UIScreen.main.bounds.width / 2 {
                    item.offset = -1000
                    deleteItem()
                } else if -(item.offset ?? 0.0) > 50 {
                    item.isSwiped = true
                    item.offset = -90
                } else {
                    item.isSwiped = false
                    item.offset = 0
                }
            } else {
                item.isSwiped = false
                item.offset = 0
            }
        }
    }
    
    // Removing Item
    func deleteItem() {
        
        items.removeAll { (item) -> Bool in
            CartCache.deleteProduct(product: item)
            return self.item.id == item.id
        }
    }
    
}

func getPrice(value: Float) -> String {
    let format = NumberFormatter()
    format.numberStyle = .currency
    format.currencyCode = "SAR"
    return format.string(from: NSNumber(value: value)) ?? ""
}

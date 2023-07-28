//
//  OrderRow.swift
//  AppStore
//
//  Created by Yahaya on 02/07/2023.
//

import Foundation
import SwiftUI
struct OrderRow:View{
    var order:Order
    @State var isClick = false
    @EnvironmentObject var orders:OrderViewModel
    var body: some View{
        HStack{
            Image(order.status.elementsEqual("ملغية لعدم الدفع") ? "t" : "multiply").resizable().frame(width: 40,height: 40)
            VStack{
                Text("#\(order.invoice_id)")
                    .font(Font.custom(appFont, size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10))
                    .frame(maxWidth: .infinity,alignment: .leading).padding(.bottom,8)
                HStack{
                    Text("\(order.price) SAR")
                        .font(Font.custom(appFont, size: 14))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(red: 0.04, green: 0.45, blue: 0.97))
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text(order.getData() ?? "")
                        .font(Font.custom(appFont, size: 14))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10))
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                VStack{
                    ForEach(order.products) { item in
                        Text(item.title)
                            .font(Font.custom(appFont, size: 14))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10))
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                }
            }.padding()
           
            
            Button {
                orders.isClick.toggle()
                orders.selectedOrder = order

            } label: {
                Text("عرض").foregroundColor(.white)
            }.tint(Color(red: 0.04, green: 0.45, blue: 0.97)).buttonStyle(.borderedProminent)

           
            
        }.frame(maxWidth: .infinity).padding(8).listRowSeparator(.hidden).background(Color(hex: "FBFBFB")).listRowInsets(.init(top: 0,leading: 8,bottom: 20,trailing: 8)).cornerRadius(15).sheet(isPresented: $orders.isClick) {
            WebView(url: URL(string: orders.selectedOrder?.invoice_url ?? "")!)
                               .ignoresSafeArea()
                               .navigationTitle("Payment")
                               .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct OrderRow_Previews: PreviewProvider {

    static var previews: some View {
        OrderRow(order: Order(id: 0, user_id: 0, category: Category(id: 0, title: "", icon: ""), products: [Product(id: 0, category_id: 0, visitors: 0, sort: 0, title: "", icon: "", description: "", price: "", product_type: "", delivery_time: "", show_in_home: "")], price: "", invoice_url: "", invoice_id: "", status: "", created_at: "", updated_at: "")).environmentObject(OrderViewModel())
    }
}

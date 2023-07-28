//
//  OrdersScreen.swift
//  AppStore
//
//  Created by Yahaya on 02/07/2023.
//

import Foundation
import SwiftUI

struct OrdersScreen: View {
    
    @State private var selectedTabIndex = 0
    var tabs = ["جميع الطلبات", "طلبات بانتظار الدفع","ملغية بسبب الدفع"]
    
    @EnvironmentObject var orders:OrderViewModel
    

    var body: some View {
        VStack(alignment: .leading) {
            
            SlidingTabView(selection: self.$selectedTabIndex, tabs: tabs,font: .custom(appFont, size: 15))
            
            switch selectedTabIndex {
            case 0:
                if orders.orders.count > 0{
                    List(orders.orders) {item in
                        OrderRow(order: item).environmentObject(orders)
                    }.listStyle(.plain)
                }else if orders.isLoading{
                    ProgressView() {
                        Text("تحميل")
                    }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                }else{
                        Text("لا يوجد طلبات")
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                }
            case 1:
                if orders.orders.count > 0{
                    
                    List(orders.orders.filter({$0.status.elementsEqual("طلبات بانتظار الدفع")})) {item in
                        OrderRow(order: item).environmentObject(orders)
                    }.listStyle(.plain)
                }else if orders.isLoading{
                    ProgressView() {
                        Text("تحميل")
                    }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                }else{
                    Text("لا يوجد طلبات")
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
            }
            case 3:
                if orders.orders.count > 0{
                    
                    List(orders.orders.filter({$0.status.elementsEqual("ملغية لعدم الدفع")})) {item in
                        OrderRow(order: item).environmentObject(orders)
                    }.listStyle(.plain)
                }else if orders.isLoading{
                    ProgressView() {
                        Text("تحميل")
                    }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                }else{
                    Text("لا يوجد طلبات")
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
            }
            default:
                EmptyView()
            }
                        
        }.onAppear{
            orders.getOrders()
        }.toolbar {
            
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("طلباتي")
                        .font(.custom(appFont, size: 20))
                        .foregroundColor(Color.black)
                }
            }
            
        }
        
        
    }
}

struct OrdersScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        OrdersScreen().environmentObject(OrderViewModel())
    }
}

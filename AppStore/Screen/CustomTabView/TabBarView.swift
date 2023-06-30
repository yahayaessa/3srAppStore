//
//  TabBarView.swift
//  CenterTabBar
//
//  Created by Satyadev Chauhan on 07/03/23.
//

import SwiftUI

enum Tab: String {
    case home = "الرئيسية"
    case present = "الشروحات"
    case category = "الاقسام"
    case myorders = "طلباتي"
    case user = "الحساب"
    
    var image: String {
        switch self {
        case .home: return "home"
        case .present: return "Discovery"
        case .category: return "Category"
        case .myorders: return "Bag1"
        case .user: return "Profile 1"
        }
    }
}

struct TabBarView: View {
    
    @State var selected: Tab
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    switch selected {
                    case .home:
                        HomeScreen()
                    case .present:
                        Text(Tab.present.rawValue)
                    case .category:
                        Text(Tab.category.rawValue)
                    case .myorders:
                        Text(Tab.myorders.rawValue)
                    case .user:
                        Text(Tab.user.rawValue)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        
                        
                        HStack {
                            
                            TabBarItemView(selected: $selected, tab: .category, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .present, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(Color(hex: "0B74F7"))
                                    .frame(width: 65 , height: 65)
                                    .shadow(radius: 4)
                                Image("3sr")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40 , height: 40)
                                    .foregroundColor(.accentColor)
                            }
                            .offset(y: -geometry.size.height/8/2)
                            .onTapGesture {
                                selected = .home
                            }
                            
                            TabBarItemView(selected: $selected, tab: .myorders, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .user, width: geometry.size.width/5, height: geometry.size.height/28)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color.white.opacity(0.9).shadow(radius: 0.5))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selected: Tab.home)
    }
}

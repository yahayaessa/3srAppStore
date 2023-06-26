//
//  TabBarView.swift
//  CenterTabBar
//
//  Created by Satyadev Chauhan on 07/03/23.
//

import SwiftUI

enum Tab: String {
    
    case home = "Home"
    case category = "Category"
    case message = "Message"
    case user = "Account"
    
    var image: String {
        switch self {
        case .home: return "house"
        case .category: return "magnifyingglass"
        case .message: return "message"
        case .user: return "person"
        }
    }
}

struct TabBarView: View {
    
    @State var selected: Tab = .home
    @State var showMenu = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    
                    Spacer()
                    
                    switch selected {
                    case .home:
                        Text(Tab.home.rawValue)
                    case .category:
                        Text(Tab.category.rawValue)
                    case .message:
                        Text(Tab.message.rawValue)
                    case .user:
                        Text(Tab.user.rawValue)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        
                        
                        HStack {
                            
                            TabBarItemView(selected: $selected, tab: .home, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .category, width: geometry.size.width/5, height: geometry.size.height/28)
                            
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
                                
                            }
                            
                            TabBarItemView(selected: $selected, tab: .message, width: geometry.size.width/5, height: geometry.size.height/28)
                            
                            TabBarItemView(selected: $selected, tab: .user, width: geometry.size.width/5, height: geometry.size.height/28)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height/8)
                        .background(Color.gray.opacity(0.01).shadow(radius: 2))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

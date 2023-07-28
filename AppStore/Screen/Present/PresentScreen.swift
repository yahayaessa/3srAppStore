//
//  PresentScreen.swift
//  AppStore
//
//  Created by Yahaya on 01/07/2023.
//

import Foundation
import SwiftUI

struct PresentScreen: View {
    
    @State private var items: [Present] = [Present(id: 0, title: "asdasd", image: "asdas"),Present(id: 1, title: "asdasd", image: "asdas"),Present(id: 2, title: "asdasd", image: "asdas"),Present(id: 3, title: "asdasd", image: "asdas"),Present(id:4, title: "asdasd", image: "asdas"),Present(id: 5, title: "asdasd", image: "asdas")]
    
    var body: some View {
        List(items) {item in
            PresentRow(presents: item)
        }
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("الشروحات")
                            .font(.custom(appFont, size: 20))
                            .foregroundColor(Color.black)
                    }
                }
                
            }
    }
}

struct PresentScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        PresentScreen()
        
    }
}

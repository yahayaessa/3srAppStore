//
//  YAButton.swift
//  AppStore
//
//  Created by Yahaya on 24/06/2023.
//

import Foundation
import SwiftUI

struct YAButtonBackground:View{
    var title: String

    var body: some View{
        Rectangle()
            .foregroundColor(.clear)
            .frame( height: 55)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.42, green: 0.67, blue: 0.98), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.04, green: 0.45, blue: 0.97), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.96, y: 0.87),
                    endPoint: UnitPoint(x: 0.03, y: 0)
                )
            )
            .cornerRadius(14).overlay(
                Text(title).foregroundColor(.white)
            )
        

    }
}

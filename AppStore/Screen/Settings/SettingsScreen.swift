//
//  Settings.swift
//  AppStore
//
//  Created by Yahaya on 28/07/2023.
//

import SwiftUI

struct SettingsScreen: View {
    @State var notif = false
    var body: some View {
        Form{
            Toggle(isOn: $notif) {
                Text("تعطيل الاشعارات").font(.custom(appFont, size: 18))
            }
        }.navigationTitle("الاعدادات")
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}

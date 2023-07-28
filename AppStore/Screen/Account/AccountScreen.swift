//
//  AccountScreen.swift
//  AppStore
//
//  Created by Yahaya on 02/07/2023.
//

import Foundation
import SwiftUI


struct AccountScreen: View {
    
    var body: some View {
        VStack{
            Spacer()
            Ellipse()
                  .foregroundColor(.clear)
                  .background{
                      Image("Profile 2").resizable().frame(width: 80,height: 80)
                  }.frame(width: 120, height: 120).background(Color.gray)
                .clipShape(Circle())
            Text(UserProfileCache.get()?.email ?? "")
            Text("@"+(UserProfileCache.get()?.name ?? "") )
                .font(Font.custom(appFont, size: 14))
                .lineSpacing(26)
                .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10))
                .multilineTextAlignment(.center).frame(height: 30).padding(.bottom,20)
            VStack(spacing: 20) {
                NavigationLink {
                    DetalisProfileScreen()
                } label: {
                    AccountCell(image: "Profile 2", title: "الحساب والمعلومات الشخصية")
                }
                NavigationLink {
                    SettingsScreen()
                } label: {
                    AccountCell(image: "Setting", title: "الإعدادات")
                }
                

                Button {
                    UserProfileCache.remove()
                    goToMainView()
                } label: {
                    AccountCell(image: "Logout", title: "تسجيل الخروج")
                }
                Button {
                    UserProfileCache.remove()
                    goToMainView()
                } label: {
                    AccountCell(image: "", title: "حذف الحساب", systemImage: "xmark.circle.fill")
                }
            }.padding(.horizontal,30)
           
            Spacer()
            Spacer()

        }.toolbar {
            
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("الملف الشخصي")
                        .font(.custom(appFont, size: 20))
                        .foregroundColor(Color.black)
                }
            }
            
        }
    }
}


struct AccountCell: View {
    var image: String
    var title: String
    var systemImage:String?
    var body: some View{
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 20) {
                if systemImage != nil{
                    Image(systemName: systemImage ?? "").tint(.black)
                }else{
                    Image(image)
                }
                Text(title)
                             .font(Font.custom(appFont, size: 14))
                             .foregroundColor(Color(red: 0.27, green: 0.29, blue: 0.25))
                Spacer()
                Image("Arrow---Left")

            }
            Rectangle()
                  .foregroundColor(.clear)
                  .frame( height: 1)
                  .overlay(
                    Rectangle()
                      .stroke(Color(red: 0.44, green: 0.44, blue: 0.44), lineWidth: 0.50)
                  );
        }
       
    }
}
struct AccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountScreen()
    }
}





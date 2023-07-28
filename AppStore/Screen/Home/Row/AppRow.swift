//
//  AppRow.swift
//  AppStore
//
//  Created by Yahaya on 03/07/2023.
//

import Foundation
import SwiftUI

struct AppRow:View{
    var app:Application
    @ObservedObject var viewModel:ApplicationsViewModel
    @State var isClick = false
    
    @State var state: ApplicationsViewModel.State = .good
    
    var body: some View{
        HStack{
            AsyncImage(url: URL(string: app.icon_file_url ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.4)
            }.frame(width: 55,height: 55).cornerRadius(7).padding(.leading,16).padding(.top,8).padding(.bottom,8)

            VStack(spacing: 4){
                Text(app.display_name)
                        .font(Font.custom(appFont, size: 18))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(red: 0.04, green: 0.45, blue: 0.97))
                        .frame(maxWidth: .infinity,alignment: .leading)
                Text(app.version)
                        .font(Font.custom(appFont, size: 12))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10))
                        .frame(maxWidth: .infinity,alignment: .leading)
                Text(app.ipa_size)
                        .font(Font.custom(appFont, size: 12))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10))
                        .frame(maxWidth: .infinity,alignment: .leading)
                
            }.padding(.leading,12)
            
            Button {
                state = .isLoading
                viewModel.getApp(url: app.temp_sign_url, completed: {
                        downloadApp(url: viewModel.app)
                    state = .loadedAll
                })
                
            } label: {
                HStack(alignment: .center){
                    switch state{
                    case .isLoading:
                        ProgressView("التجهيز").progressViewStyle(.circular).frame(width: 80)
                    case.good:
                        EmptyView()
                        YAButtonBackground(title: "تثبيت").frame(width: 80, height: 33)
                    case .loadedAll:
                        VStack{
                            Image("t").resizable().frame(width: 50,height: 50)
                            Text("تم")
                        }.frame(width: 80)
                    case .error(_):
                        Image("multiply").resizable().frame(width: 50,height: 50)
                    }
                }
               
            }.padding(.horizontal,16)
            
        }.frame(maxWidth: .infinity).padding(8).listRowSeparator(.hidden).background(Color(hex: "FBFBFB")).listRowInsets(.init(top: 0,leading: 8,bottom: 20,trailing: 8)).cornerRadius(15)
    }
    
    func downloadApp(url:String){
//        DispatchQueue.main.async {
            UIApplication.shared.open( URL(string: "itms-services://?action=download-manifest&url=" + url)!)
//        }
    }
}
struct AppRow_Previews: PreviewProvider {

    static var previews: some View {
        AppRow(app: Application(id: 1, display_name: "", version: "", support_duplicate: 1, ipa_size: "", temp_sign_url: ""),viewModel: ApplicationsViewModel())
    }
}

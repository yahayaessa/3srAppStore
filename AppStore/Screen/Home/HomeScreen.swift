//
//  Categories.swift
//  AppStore
//
//  Created by Yahaya on 26/06/2023.
//

import SwiftUI

struct HomeScreen: View {
    private let images = ["slide","slide","slide"]
    
    @EnvironmentObject var categoires:CategoryViewModel

    @EnvironmentObject var homeViewModel:HomeViewModel
    
    @EnvironmentObject var applecations:ApplicationsViewModel
    
    @EnvironmentObject var authViewModel:AuthViewModel

    var body: some View {
        GeometryReader { geometry in
            
                List {
                    VStack (alignment: .leading){
                        ImageCarouselView(numberOfImages: $homeViewModel.sliders.count) {
                            ForEach(homeViewModel.sliders) { image in
                                AsyncImage(url: URL(string:image.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width - 60)
                                        .padding(.horizontal,16)
                                } placeholder: {
                                    ZStack{
                                        Color.gray.opacity(0.3)
                                    }
                                }
                            }
                        }.padding(0)
                    }.frame(height: geometry.size.width/1.7, alignment: .center).listRowSeparator(.hidden)
                    CategoriesRow(categoryName: "التصنيفات", items: categoires.categories)
                        .listRowInsets(EdgeInsets()).listRowSeparator(.hidden).padding(.bottom,16)
                    BestProductsRow().environmentObject(homeViewModel).listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    if let user = UserProfileCache.get(){
                        if user.device_udid != nil{
                            Group{
                                Text("التطبيقات").font(.custom(appFont, size: 20)).listRowSeparator(.hidden)
                                ForEach(applecations.items) { item in
                                    
                                    AppRow(app: item,viewModel: applecations).onAppear{
                                        if item.id == applecations.items.last?.id{
                                            applecations.getApplications()
                                        }
                                    }.listRowSeparator(.hidden).listRowBackground(Color.clear)
                                    
                                }.listRowSeparator(.hidden)
                                if applecations.isLoading{
                                    ProgressView("تحميل ...").progressViewStyle(.circular)
                                        .frame(maxWidth: .infinity).listRowSeparator(.hidden)
                                }else{
                                    EmptyView()
                                }
                                
                            }
                        }
                    }
                    
                }.listStyle(.plain).listRowSeparator(.hidden)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink {
                    CartView()
                }label: {
                    Image("Buy")

                }
                
                
            }
            ToolbarItem(placement: .principal) {
                            VStack {
                                Text("الرئيسية")
                                  .font(.custom(appFont, size: 20))
                                  .foregroundColor(Color.black)
                            }
                        }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    ProductsSearchScreen().environmentObject(ProductsViewModel(category: nil))
                } label: {
                    Image("Search")
                }
 
                
            }
            
            
        }.onAppear{
            homeViewModel.getSlider()
            categoires.getCategories()
            applecations.getApplications()
            authViewModel.profile()
            homeViewModel.getFeaturedProducts()
        }.alert( isPresented: $authViewModel.isAuth) {
            Alert(
                            title: Text("التحقق من البريد الإلكتروني"),
                            message: Text("سيتم ارسال رابط تحقق على البريد الإلكتروني"),
                            primaryButton: .destructive(Text("ارسال")) {
                                authViewModel.verifyEmail()
                            },
                            secondaryButton: .cancel(Text("لاحقا"))
                        )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(HomeViewModel()).environmentObject(CategoryViewModel()).environmentObject(ApplicationsViewModel()).environmentObject(AuthViewModel())
    }
}

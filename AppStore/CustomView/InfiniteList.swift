//
//  InfiniteList.swift
//  AppStore
//
//  Created by Yahaya on 07/07/2023.
//

import Foundation
import SwiftUI

struct InfiniteList<Data, Content>: View
    where Data : RandomAccessCollection, Data.Element : Hashable, Content : View  {
  @Binding var data: Data // 1
  @Binding var isLoading: Bool // 2
  let loadMore: () -> Void // 3
  let content: (Data.Element) -> Content // 4

  init(data: Binding<Data>,
       isLoading: Binding<Bool>,
       loadMore: @escaping () -> Void,
       @ViewBuilder content: @escaping (Data.Element) -> Content) { // 5
    _data = data
    _isLoading = isLoading
    self.loadMore = loadMore
    self.content = content
  }

  var body: some View {
    List {
       ForEach(data, id: \.self) { item in
         content(item)
           .onAppear {
              if item == data.last { // 6
                loadMore()
              }
           }
       }
       if isLoading { // 7
         ProgressView()
           .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
       }
    }.onAppear(perform: loadMore) // 8
  }
}

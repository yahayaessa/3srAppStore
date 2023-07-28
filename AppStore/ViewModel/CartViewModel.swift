//
//  CartViewModel.swift
//  Cart
//
//  Created by RJ Hrabowskie on 10/27/20.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var items:[Product] = CartCache.loadPlaces().products
    @Published var invoiceURL:String?
//        Product(name: "Peace Skull Shirt", details: "Gray - L", image: "p1", price: 20.99, quantity: 1, offset: 0, isSwiped: false),
//        Item(name: "Myrtle Beach Sweater", details: "White - M", image: "p2", price: 25.99, quantity: 2, offset: 0, isSwiped: false),
//        Item(name: "Eywa Hoodie", details: "White - L", image: "p3", price: 22.99, quantity: 1, offset: 0, isSwiped: false),
//        Item(name: "Russ Shirt", details: "Light Red - L", image: "p4", price: 15.20, quantity: 1, offset: 0, isSwiped: false),
//        Item(name: "Comfort Jacket", details: "Black - M", image: "p5", price: 29.99, quantity: 1, offset: 0, isSwiped: false)
//    ]
    
    func endOrder( completeBlock: @escaping ((Bool,String?)->())){
        APIContentRepositoryType<MyService,invoiceURL>(MyService.buy(CartCache.loadPlaces().products)).requestContent { result in
                do{
                    self.invoiceURL = try result.get().invoice_url
//                    self.isError = false
                    completeBlock(true,nil)
                }catch{
//                    self.isError = true
                    let errorAPI = error as! APIError
                    completeBlock(false,errorAPI.message)
                }
                
            
        }
    }
}

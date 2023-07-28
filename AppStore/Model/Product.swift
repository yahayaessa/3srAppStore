//
//  User.swift
//  AppStore
//
//  Created by Yahaya on 26/06/2023.
//

import Foundation
struct Product:Codable,Identifiable{

    var id:Int
    var category_id:Int?
    var visitors:Int?
    var sort:Int?
    var title:String
    var icon:String?
    var description:String?
    var price:String?
    var product_type:String?
    var delivery_time:String?
    var show_in_home:String?
    var quantity:Int? = 1
    var offset: CGFloat?
    var isSwiped: Bool?
    var category:Category?

}
struct CartCache {
    static let key = "products"
        
    static func saveCart(product:Product){
        Products.shared.products.append(product)
        let data = try! NSKeyedArchiver.archivedData(withRootObject: Products.shared, requiringSecureCoding: false)
        UserDefaults.standard.set(data, forKey: CartCache.key)
    }
    static func updatePrice(product:Product){
        if let row = Products.shared.products.firstIndex(where: {$0.id == product.id}) {
            Products.shared.products[row] = product
        }
        let data = try! NSKeyedArchiver.archivedData(withRootObject: Products.shared, requiringSecureCoding: false)
        UserDefaults.standard.set(data, forKey: CartCache.key)
    }
    static func deleteProduct(product:Product){
        if let row = Products.shared.products.firstIndex(where: {$0.id == product.id}) {
            Products.shared.products.remove(at: row)
        }
        let data = try! NSKeyedArchiver.archivedData(withRootObject: Products.shared, requiringSecureCoding: false)
        UserDefaults.standard.set(data, forKey: CartCache.key)
    }
    static func loadPlaces()->Products{
        let loadedData = UserDefaults.standard.data(forKey: key)!
        Products.shared = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(loadedData) as! Products
        return Products.shared
    }
}
class Products: NSObject, NSCoding {
    private override init() { }
    static var shared = Products()
    var products: [Product] = []
    required init(coder decoder: NSCoder) {
        products = try! JSONDecoder().decode([Product].self, from: decoder.decodeData()!)
    }
    func encode(with coder: NSCoder) {
        try! coder.encode(JSONEncoder().encode(products))
    }
}

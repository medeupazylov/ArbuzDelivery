import UIKit

struct AllProductModels: Codable {
    let fruits: [ProductModel]
    let vegetables: [ProductModel]
    let milkProducts: [ProductModel]
}

struct ProductModel: Codable, Hashable {
    let name: String
    let price: Float
    let availability: Bool
    let amount: Float
    let unit: String
    let imageLink: String
    let countable: Bool
    let small: String
    let medium: String
    let large: String
}

struct ProductCartModel {
    let product: ProductModel
    var count: Int
}

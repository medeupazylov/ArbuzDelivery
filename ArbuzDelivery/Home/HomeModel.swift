import UIKit

protocol HomeModelProtocol {
    var allProductsModel: AllProductModels { get set }
}

struct HomeModel: HomeModelProtocol {
    var allProductsModel: AllProductModels = AllProductModels(fruits: [], vegetables: [], milkProducts: [])
}

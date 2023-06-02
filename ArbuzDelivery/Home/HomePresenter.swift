import UIKit

protocol HomeViewProtocol: AnyObject {
    func updateProductsInfo(allProductModels: AllProductModels)
    func updateHomeView()
}


protocol HomePresenterProtocol {
    var homeView: HomeViewProtocol? { get set }
    func addProductToCart(product: ProductModel)
    func removeProductFromCart(product: ProductModel)
    func getProductNumberInCart(product: ProductModel) -> Int
    func updateHomeView()
}


class HomePresenter: HomePresenterProtocol {
    
//MARK: - Properties
    
    weak var tabConnector: TabBarConnectorProtocol?
    
    private var homeModel: HomeModelProtocol
    
    weak var homeView: HomeViewProtocol? {
        didSet{
            homeView?.updateProductsInfo(allProductModels: homeModel.allProductsModel)
        }
    }
    
    
//MARK: - Lifecycle
    
    init(newHomeModel: HomeModelProtocol) {
        self.homeModel = newHomeModel
        self.homeModel.allProductsModel = getProductData()
    }
   
    
//MARK: - Private methods
    
    private func getProductData() -> AllProductModels {
        if let path = Bundle.main.path(forResource: "products", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let json = try JSONDecoder().decode(AllProductModels.self, from: data)
                return json
            } catch {
                return AllProductModels(fruits: [], vegetables: [], milkProducts: [])
            }
        }
        return AllProductModels(fruits: [], vegetables: [], milkProducts: [])
    }
    
    
//MARK: - Protocol Methods
    
    func addProductToCart(product: ProductModel) {
        tabConnector?.addProductToCart(product: product)
    }
    
    func removeProductFromCart(product: ProductModel) {
        tabConnector?.removeProductFromCart(product: product)
    }
    
    func getProductNumberInCart(product: ProductModel) -> Int {
        if let count = tabConnector?.getProductNumberInCart(product: product) {
            return count
        }
        return 0
    }
    
    func updateHomeView() {
        homeView?.updateHomeView()
    }
    
}

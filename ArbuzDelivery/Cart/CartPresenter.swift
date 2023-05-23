import UIKit

protocol CartViewProtocol: AnyObject {
    func updateTable()
    
    func getTotalCost() -> Float
}

protocol CartPresenterProtocol{
    var cartView: CartViewProtocol? { get set }
    
    func addProductToCart(product: ProductModel)
    func removeProductFromCart(product: ProductModel)
    func getProductNumberInCart(product: ProductModel) -> Int
    func getCartList() -> [ProductCartModel]
    func getCartSize() -> Int
    func getTotalCost() -> Float
    func addSubscription(subscription: SubscriptModel)
}


class CartPresenter: CartPresenterProtocol {
    
    private var cartModel: CartModelProtocol
    
    weak var cartView: CartViewProtocol?
    
    weak var tabConnector: TabBarConnectorProtocol?
    
    init(newCartModel: CartModelProtocol) {
        self.cartModel = newCartModel
    }
    
    func addProductToCart(product: ProductModel) {
        print("addded")
        cartModel.addProductToCart(product: product)
        tabConnector?.updateHomeView()
        cartView?.updateTable()
    }
    
    func removeProductFromCart(product: ProductModel) {
        print("removed")
        cartModel.removeProductFromCart(product: product)
        tabConnector?.updateHomeView()
        cartView?.updateTable()
    }
    
    func getProductNumberInCart(product: ProductModel) -> Int {
        return cartModel.getProductCount(product: product)
    }
    
    
    func getCartList() -> [ProductCartModel] {
        return cartModel.cart
    }
    
    func getCartSize() -> Int {
        return cartModel.cart.count
    }
    
    func getTotalCost() -> Float {
        var cost: Float = 0
        for item in cartModel.cart {
            cost = cost + (Float(item.count) * item.product.price)
        }
        return cost
    }
    
    func addSubscription(subscription: SubscriptModel) {
        let subscription = SubscriptModel(title: subscription.title, cart: cartModel.cart, date: subscription.date, address: subscription.address)
        tabConnector?.addSubscription(subscription: subscription)
        cartModel.clearCart()
        tabConnector?.updateHomeView()
        cartView?.updateTable()
        
    }
    
}

import UIKit

protocol CartModelProtocol {
    var cart: [ProductCartModel] { get }
    
    mutating func addProductToCart(product: ProductModel)
    
    mutating func removeProductFromCart(product: ProductModel)
    
    func getProductCount(product: ProductModel) -> Int
    
    mutating func clearCart()
        
}


struct CartModel: CartModelProtocol {
    
    var cart: [ProductCartModel] = []
    
    func getProductCount(product: ProductModel) -> Int {
        for i in 0..<cart.count {
            if product == cart[i].product {
                return cart[i].count
            }
        }
        return 0
    }
    
        
    mutating func addProductToCart(product: ProductModel) {
        for i in 0..<cart.count {
            if product == cart[i].product {
                cart[i].count = cart[i].count + 1
                return
            }
        }
        
        cart.append(ProductCartModel(product: product, count: 1))
        
    }
        
    mutating func removeProductFromCart(product: ProductModel) {
        for i in 0..<cart.count {
            if product == cart[i].product {
                if(cart[i].count>0) {
                    cart[i].count = cart[i].count - 1
                }
                if(cart[i].count == 0) {
                    cart.remove(at: i)
                }
                return
            }
        }
    }
    
    mutating func clearCart() {
        cart = []
    }
    
    
        

}

//
//  ViewController.swift
//  ArbuzDelivery
//
//  Created by Medeu Pazylov on 19.05.2023.
//

import UIKit

protocol TabBarConnectorProtocol: AnyObject {
    func addProductToCart(product: ProductModel)
    func removeProductFromCart(product: ProductModel)
    func getProductNumberInCart(product: ProductModel) -> Int
    func updateHomeView()
    func addSubscription(subscription: SubscriptModel)
}


class TabBar: UITabBarController {
    
    var homePresenter: HomePresenterProtocol?
    var cartPresenter: CartPresenterProtocol?
    var subscriptionPresenter: SubscriptionPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .orange
        setupVCs()
        setupViews()
        setupLayout()
    }
    
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 10)
        ], for: .normal)
        navController.tabBarItem.image = image
        navController.isNavigationBarHidden = true
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }

    func setupVCs() {
        
        let homeModel = HomeModel()
        let homePresenter = HomePresenter(newHomeModel: homeModel)
        let homeView = HomeView(newHomePresenter: homePresenter)
        homePresenter.homeView = homeView
        homePresenter.tabConnector = self
        self.homePresenter = homePresenter
        
        
        let cartModel = CartModel()
        let cartPresenter = CartPresenter(newCartModel: cartModel)
        let cartView = CartView(newCartPresenter: cartPresenter)
        cartPresenter.cartView = cartView
        cartPresenter.tabConnector = self
        self.cartPresenter = cartPresenter
        
        let subscriptionModel = SubscriptionModel()
        let subscriptionPresenter = SubscriptonPresenter(newSubscriptionModel: subscriptionModel)
        let subscriptionView = SubscriptionView(newSubscriptionPresenter: subscriptionPresenter)
        subscriptionPresenter.subscriptionView = subscriptionView
        subscriptionPresenter.tabConnector = self
        self.subscriptionPresenter = subscriptionPresenter
        
        viewControllers = [
            createNavController(for: homeView, title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: cartView, title: NSLocalizedString("Cart", comment: ""), image: UIImage(systemName: "cart")!),
            createNavController(for: subscriptionView, title: NSLocalizedString("Subscriptions", comment: ""), image: UIImage(systemName: "text.badge.checkmark")!),
            createNavController(for: ProfileView(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!)
        ]
    }
    
    func setupViews() {

    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([

        ])
    }
    
}

extension TabBar: TabBarConnectorProtocol {
    func addSubscription(subscription: SubscriptModel) {
        subscriptionPresenter?.addToSubscriptions(subscription: subscription)
    }
    
    func updateHomeView() {
        homePresenter?.updateHomeView()
    }
    
    
    func addProductToCart(product: ProductModel) {
        cartPresenter?.addProductToCart(product: product)
    }
    
    func removeProductFromCart(product: ProductModel) {
        cartPresenter?.removeProductFromCart(product: product)
    }
    
    func getProductNumberInCart(product: ProductModel) -> Int {
        if let count = cartPresenter?.getProductNumberInCart(product: product) {
            return count
        }
        return 0
    }
    
    
}



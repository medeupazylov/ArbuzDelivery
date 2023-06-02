//
//  CartViewController.swift
//  ArbuzDelivery
//
//  Created by Medeu Pazylov on 19.05.2023.
//

import UIKit

class CartView: UIViewController {
    
    
//MARK: - Properties
    
    let cartPresenter: CartPresenterProtocol

    
//MARK: - Lifecycle
    init(newCartPresenter: CartPresenterProtocol) {
        self.cartPresenter = newCartPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        subscriptButton.addTarget(self, action: #selector(subscriptAction), for: .touchUpInside)

    }

    
//MARK: - Private Methods
    private func setupViews() {
        view.addSubview(container)
        container.addSubview(navigationView)
        container.addSubview(cartTableView)
        container.addSubview(subscriptButton)
        container.addSubview(noProductLabel)
        navigationView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            container.leftAnchor.constraint(equalTo: view.leftAnchor),
            container.rightAnchor.constraint(equalTo: view.rightAnchor),
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            navigationView.rightAnchor.constraint(equalTo: container.rightAnchor),
            navigationView.leftAnchor.constraint(equalTo: container.leftAnchor),
            navigationView.topAnchor.constraint(equalTo: container.topAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 115),
            
            titleLabel.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor, constant: 25.0),
            
            cartTableView.leftAnchor.constraint(equalTo: container.leftAnchor),
            cartTableView.rightAnchor.constraint(equalTo: container.rightAnchor),
            cartTableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 10),
            cartTableView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            noProductLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            noProductLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            subscriptButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            subscriptButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            subscriptButton.heightAnchor.constraint(equalToConstant: 55),
            subscriptButton.widthAnchor.constraint(equalToConstant: 180)
            
        ])
    }
    
    private func updateView() {
        noProductLabel.isHidden = cartPresenter.getCartSize() == 0 ? false : true
        subscriptButton.isHidden = cartPresenter.getCartSize() == 0 ? true : false
    }

    
//MARK: - Button Actions
    @objc private func subscriptAction() {
        let subscriptView = SubscriptView { subscriptModel in
            self.cartPresenter.addSubscription(subscription: subscriptModel)
        }
        if let sheet = subscriptView.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        subscriptView.cartView = self
        self.present(subscriptView, animated: true, completion: nil)
        
    }
    
    
//MARK: - UI Elements
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private let navigationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.layer.cornerRadius = 30.0
        return view
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Cart"
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = .white
        return label
    } ()
    
    private let cartTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CartTableViewCell.self, forCellReuseIdentifier: "reusableCell")
        table.backgroundColor = .clear
        table.showsHorizontalScrollIndicator = false
        table.separatorColor = .clear
        table.allowsSelection = false
        return table
    } ()
    
    private let subscriptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.backgroundColor = .orange
        button.layer.cornerRadius = 18.0
        button.setAttributedTitle(NSAttributedString(string: "Subscript", attributes: [
            NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 18),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]), for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 5

        return button
    } ()
    
    private let noProductLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No products in cart"
        label.font = MontserratFont.makefont(name: .semibold, size: 18.0)
        label.textColor = .systemGray
        return label
    } ()

}


//MARK: - CartViewProtocol

extension CartView: CartViewProtocol {
    func getTotalCost() -> Float {
        return cartPresenter.getTotalCost()
    }
    
    func updateTable() {
        self.cartTableView.reloadData()
        self.updateView()
        print("table updated")
    }
}


//MARK: - UITableViewDelegate

extension CartView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}


//MARK: - UITableViewDataSource

extension CartView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        let cart = cartPresenter.getCartList()
        cell.product = cart[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartPresenter.getCartSize()
    }
}


//MARK: - CartTableViewCellDelegate

extension CartView: CartTableViewCellDelegate {
    func addProductToCart(product: ProductModel) {
        cartPresenter.addProductToCart(product: product)
    }
    
    func removeProductFromCart(product: ProductModel) {
        cartPresenter.removeProductFromCart(product: product)
    }
    
    
}

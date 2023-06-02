//
//  ViewController.swift
//  ArbuzDelivery
//
//  Created by Medeu Pazylov on 19.05.2023.
//

import UIKit

class HomeView: UIViewController {
    
//MARK: - Properties
    
    let homePresenter: HomePresenterProtocol
    
    
//MARK: - Lifecycle
    
    init(newHomePresenter: HomePresenterProtocol) {
        self.homePresenter = newHomePresenter
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    
//MARK: - Private methods
    
    private func setupViews() {
        view.addSubview(container)
        container.addSubview(scrollView)
        container.addSubview(navigationView)
        navigationView.addSubview(searchBar)
        navigationView.addSubview(greetingView)
        scrollView.addSubview(mainStack)
        mainStack.addArrangedSubview(fruitsSection)
        mainStack.addArrangedSubview(vegetablesSection)
        mainStack.addArrangedSubview(milkSection)
    }
    
    private func openChooseSizeView(product: ProductModel) {
        let chooseSizeView = ChooseSizeView(product: product)
        if let sheet = chooseSizeView.sheetPresentationController {
            sheet.detents = [.medium()]
        }
    
        self.present(chooseSizeView, animated: true, completion: nil)
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
            navigationView.heightAnchor.constraint(equalToConstant: 150),

            searchBar.leftAnchor.constraint(equalTo: navigationView.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: navigationView.rightAnchor, constant: -10),
            searchBar.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),

            greetingView.leftAnchor.constraint(equalTo: navigationView.leftAnchor, constant: 20),
            greetingView.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -10),
            
            
            scrollView.leftAnchor.constraint(equalTo: container.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: container.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: container.topAnchor, constant: 160),
            scrollView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            
            mainStack.leftAnchor.constraint(equalTo: container.leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: container.rightAnchor),
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25),

            fruitsSection.leftAnchor.constraint(equalTo: mainStack.leftAnchor),
            fruitsSection.rightAnchor.constraint(equalTo: mainStack.rightAnchor),

            vegetablesSection.leftAnchor.constraint(equalTo: mainStack.leftAnchor),
            vegetablesSection.rightAnchor.constraint(equalTo: mainStack.rightAnchor),

            milkSection.leftAnchor.constraint(equalTo: mainStack.leftAnchor),
            milkSection.rightAnchor.constraint(equalTo: mainStack.rightAnchor),
            
        ])
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
    
    private let searchBar: SearchBarView = {
        let searchBar = SearchBarView()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    } ()
    
    private let greetingView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose your fresh product!"
        label.textColor = .white
        label.font = MontserratFont.makefont(name: .bold, size: 18)
        return label
    } ()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    } ()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private lazy var fruitsSection: SectionView = {
        let section = SectionView(title: "Fruits", image: UIImage(named: "fruit")!, addAction: { productModel in
            self.homePresenter.addProductToCart(product: productModel)
        }, removeAction: { productModel in
            self.homePresenter.removeProductFromCart(product: productModel)
        }, getCountAction: { productModel in
            return self.homePresenter.getProductNumberInCart(product: productModel)
        }, chooseSizeAction: { productModel in
            self.openChooseSizeView(product: productModel)
        })
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    } ()
    
    private lazy var vegetablesSection: SectionView = {
        let section = SectionView(title: "Vegetables", image: UIImage(named: "vegetable")!, addAction: { productModel in
            self.homePresenter.addProductToCart(product: productModel)
        }, removeAction: { productModel in
            self.homePresenter.removeProductFromCart(product: productModel)
        }, getCountAction: { productModel in
            return self.homePresenter.getProductNumberInCart(product: productModel)
        }, chooseSizeAction: { productModel in
            self.openChooseSizeView(product: productModel)
        })
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    } ()
    
    private lazy var milkSection: SectionView = {
        let section = SectionView(title: "Milky Products", image: UIImage(named: "milkProduct")!, addAction: { productModel in
            self.homePresenter.addProductToCart(product: productModel)
        }, removeAction: { productModel in
            self.homePresenter.removeProductFromCart(product: productModel)
        }, getCountAction: { productModel in
            return self.homePresenter.getProductNumberInCart(product: productModel)
        }, chooseSizeAction: { productModel in
            self.openChooseSizeView(product: productModel)
        })
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    } ()
    

}


//MARK: - HomeViewProtocol

extension HomeView: HomeViewProtocol {
    func updateHomeView() {
        for view in mainStack.arrangedSubviews {
            guard let view = view as? SectionView else {return}
            view.updateProductCount()
        }
    }
    
    func updateProductsInfo(allProductModels: AllProductModels) {
        fruitsSection.loadDataToCards(data: allProductModels.fruits)
        vegetablesSection.loadDataToCards(data: allProductModels.vegetables)
        milkSection.loadDataToCards(data: allProductModels.milkProducts)
    }
}

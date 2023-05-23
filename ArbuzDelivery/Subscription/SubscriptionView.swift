//
//  ProfileViewController.swift
//  ArbuzDelivery
//
//  Created by Medeu Pazylov on 19.05.2023.
//

import UIKit

enum TableViewState {
    case generalList
    case item
}

class SubscriptionView: UIViewController {
    
    let subscriptionPresenter: SubscriptionPresenterProtocol
    var currentSubscription: SubscriptModel?
    
    var state: TableViewState = .generalList {
        didSet {
            tableView.reloadData()
            if state == .item {
                backButton.isHidden = false
                tableView.allowsSelection = false
            } else {
                backButton.isHidden = true
                tableView.allowsSelection = true
            }
        }
    }
    
    init(newSubscriptionPresenter: SubscriptionPresenterProtocol) {
        subscriptionPresenter = newSubscriptionPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(container)
        container.addSubview(navigationView)
        navigationView.addSubview(titleLabel)
        navigationView.addSubview(backButton)
        container.addSubview(tableView)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
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
            
            tableView.leftAnchor.constraint(equalTo: container.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: container.rightAnchor),
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            backButton.leftAnchor.constraint(equalTo: navigationView.leftAnchor, constant: 30),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 120),
            backButton.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    @objc func backButtonAction() {
        state = .generalList
    }
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let navigationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.layer.cornerRadius = 30.0
        return view
    } ()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Subscriptions"
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = .white
        return label
    } ()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SubscriptionTableViewCell.self, forCellReuseIdentifier: "newCell")
        table.register(CartTableViewCell.self, forCellReuseIdentifier: "reusableCell")
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.allowsSelection = true
        return table
    } ()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleToFill
        return button
    } ()
}

extension SubscriptionView: SubscriptionViewProtocol {
    
}

extension SubscriptionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sub = subscriptionPresenter.getSubscriptions()
        currentSubscription = sub[indexPath.row]
        state = .item
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension SubscriptionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if state == .generalList {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as? SubscriptionTableViewCell else {
                return UITableViewCell()
            }
            
            let sub = subscriptionPresenter.getSubscriptions()
            cell.subscription = sub[indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as? CartTableViewCell else {
                return UITableViewCell()
            }
            if let cart = currentSubscription?.cart {
                cell.product = cart[indexPath.row]
            }
            cell.version()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if state == .generalList {
            return subscriptionPresenter.getSubscriptions().count
        } else {
            guard let currentSubscription = self.currentSubscription else { return 0 }
            return currentSubscription.cart.count
        }
        
    }
    
}

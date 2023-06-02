//
//  ProfileView.swift
//  ArbuzDelivery
//
//  Created by Medeu Pazylov on 23.05.2023.
//

import UIKit

class ProfileView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    
    
    private func setupViews() {
        view.addSubview(container)
        container.addSubview(navigationView)
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
        ])
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
        label.text = "My Profile"
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = .white
        return label
    } ()

}

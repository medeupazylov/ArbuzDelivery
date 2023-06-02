//
//  ChooseSizeView.swift
//  ArbuzDelivery
//
//  Created by Medeu Pazylov on 23.05.2023.
//

import UIKit

class ChooseSizeView: UIViewController {

//MARK: - Properties
    
    let product: ProductModel
    var pressed = false
    var count: Int = 0 {
        didSet{
            if count>0 {
                countLabel.isHidden = false
                countLabel.text = "\(count)"
            } else {
                countLabel.isHidden = true
            }
        }
    }

    
//MARK: - Lifecycle
    
    init(product: ProductModel) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupView()
        setupLayout()
    }


//MARK: - Private Methods
    
    private func setupView() {
        view.addSubview(chooseTitle)
        view.addSubview(image)
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(small)
        view.addSubview(medium)
        view.addSubview(large)
        view.addSubview(addButton)
        view.addSubview(removeButton)
        view.addSubview(countLabel)
        view.addSubview(amountLabel)
        small.addTarget(self, action: #selector(sizeAction), for: .touchUpInside)
        medium.addTarget(self, action: #selector(sizeAction), for: .touchUpInside)
        large.addTarget(self, action: #selector(sizeAction), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeAction), for: .touchUpInside)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            chooseTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            chooseTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            image.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            image.topAnchor.constraint(equalTo: chooseTitle.bottomAnchor, constant: 20),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 170),
            
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            
            priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            priceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            small.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            small.topAnchor.constraint(equalTo: image.topAnchor),
            small.heightAnchor.constraint(equalToConstant: 50),
            small.widthAnchor.constraint(equalToConstant: 100),
            
            medium.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            medium.topAnchor.constraint(equalTo: small.bottomAnchor, constant: 10),
            medium.heightAnchor.constraint(equalToConstant: 50),
            medium.widthAnchor.constraint(equalToConstant: 100),
            
            large.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            large.topAnchor.constraint(equalTo: medium.bottomAnchor, constant: 10),
            large.heightAnchor.constraint(equalToConstant: 50),
            large.widthAnchor.constraint(equalToConstant: 100),
            
            countLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -45),
            countLabel.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -30),
            countLabel.heightAnchor.constraint(equalToConstant: 40),
            countLabel.widthAnchor.constraint(equalToConstant: 90),
            
            addButton.heightAnchor.constraint(equalToConstant: 80),
            addButton.widthAnchor.constraint(equalToConstant: 80),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45),
            
            removeButton.heightAnchor.constraint(equalToConstant: 58),
            removeButton.widthAnchor.constraint(equalToConstant: 58),
            removeButton.rightAnchor.constraint(equalTo: addButton.leftAnchor),
            removeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            amountLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),

        ])
    }

    
//MARK: - Button Actions
    
    @objc private func addAction() {
        if pressed == false {
            return
        }
        count = count + 1
    }
    
    @objc private func removeAction() {
        if pressed == false {
            return
        }
        count = count - 1
    }
    
    @objc private func sizeAction(_ sender: DayButton?) {
        pressed = true
        if count > 0 {
            return
        }
        guard let sender = sender else {
            return
        }
        small.didSelect = false
        medium.didSelect = false
        large.didSelect = false
        sender.didSelect = true
        if sender == small {
            amountLabel.text = product.small
            priceLabel.text = "$" + String(format: "%.2f", (product.price * 0.8) )
        }
        if sender == medium {
            amountLabel.text = product.medium
            priceLabel.text = "$\(product.price)"
        }
        if sender == large {
            amountLabel.text = product.large
            priceLabel.text = "$" + String(format: "%.2f", (product.price * 1.2) )
        }
    }
 
    
//MARK: - UI Elements
    
    private let small: DayButton = {
        let button = DayButton(text: "SMALL")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let medium: DayButton = {
        let button = DayButton(text: "MEDIUM")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let large: DayButton = {
        let button = DayButton(text: "LARGE")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let chooseTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose the size for this product"
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()

    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: product.imageLink ))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
        return image
    } ()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = product.name
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        return label
    } ()
    
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$\(product.price)"
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        label.font = MontserratFont.makefont(name: .bold, size: 30)
        return label
    } ()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    } ()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.tintColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    } ()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.text = "\(Int(product.amount)) \(product.unit)"
        label.font = MontserratFont.makefont(name: .semibold, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .orange
        label.isHidden = true
        label.layer.cornerRadius = 8
        label.text = "12"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
}

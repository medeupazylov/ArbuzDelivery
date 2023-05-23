import UIKit

class ProductCardView: UIView {
    
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
    
    private let addActionClosure: ((ProductModel) -> Void)?
    private let removeActionClosure: ((ProductModel) -> Void)?
    private let getCountActionClosure: ((ProductModel) -> Int)?
    private let chooseSizeActionClosure: ((ProductModel) -> Void)?
    
    let product: ProductModel
    
    init(product: ProductModel, addAction: ((ProductModel) -> Void)?, removeAction: ((ProductModel) -> Void)?, getCountAction: ((ProductModel) -> Int)?, chooseSizeAction: ((ProductModel) -> Void)?) {
        self.product = product
        self.addActionClosure = addAction
        self.removeActionClosure = removeAction
        self.getCountActionClosure = getCountAction
        self.chooseSizeActionClosure = chooseSizeAction
        super.init(frame: .zero)
        setupViews()
        setupLayout()
        processInfo()
        if product.countable == true {
            version2()
        }
    }
    
    private func processInfo() {
        if product.availability == false {
            removeButton.isHidden = true
            addButton.isHidden = true
            stockOut.isHidden = false
        } else {
            removeButton.isHidden = false
            addButton.isHidden = false
            stockOut.isHidden = true
        }
    }
    
    private func setupViews() {
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeAction), for: .touchUpInside)
        chooseSize.addTarget(self, action: #selector(chooseAction), for: .touchUpInside)
        self.addSubview(image)
        self.addSubview(nameLabel)
        self.addSubview(priceLabel)
        self.addSubview(addButton)
        self.addSubview(removeButton)
        self.addSubview(amountLabel)
        self.addSubview(stockOut)
        self.addSubview(countLabel)
        self.addSubview(chooseSize)

        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 160),
            self.heightAnchor.constraint(equalToConstant: 220),
            image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.0),
            image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15.0),
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5.0),
            

            priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            stockOut.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            stockOut.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            countLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            countLabel.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -10),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
            countLabel.widthAnchor.constraint(equalToConstant: 35),
            
            addButton.heightAnchor.constraint(equalToConstant: 37),
            addButton.widthAnchor.constraint(equalToConstant: 37),
            addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            removeButton.heightAnchor.constraint(equalToConstant: 30),
            removeButton.widthAnchor.constraint(equalToConstant: 30),
            removeButton.rightAnchor.constraint(equalTo: addButton.leftAnchor),
            removeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            chooseSize.heightAnchor.constraint(equalToConstant: 25),
            chooseSize.widthAnchor.constraint(equalToConstant: 80),
            chooseSize.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7),
            chooseSize.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9),
            
            amountLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2.0)
        ])
    }
    
    func updateProductCount() {
        if let count = getCountActionClosure?(product) {
            self.count = count
        }
    }
    
    func version2() {
        addButton.isHidden = true
        removeButton.isHidden = true
        chooseSize.isHidden = false
    }
    
    @objc func addAction() {
        addActionClosure?(product)
        updateProductCount()
    }
    
    @objc func removeAction() {
        removeActionClosure?(product)
        updateProductCount()
    }
    
    @objc func chooseAction() {
        chooseSizeActionClosure?(product)
        updateProductCount()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: product.imageLink ))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    } ()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = product.name
        label.font = MontserratFont.makefont(name: .semibold, size: 15)
        return label
    } ()
    
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$\(product.price)"
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        label.font = MontserratFont.makefont(name: .bold, size: 18)
        return label
    } ()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    } ()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.tintColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    } ()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.text = "\(Int(product.amount)) \(product.unit)"
        label.font = MontserratFont.makefont(name: .semibold, size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let stockOut: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.text = "Stock Out"
        label.font = MontserratFont.makefont(name: .semibold, size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    } ()
    
    let chooseSize: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        button.isHidden = true
        button.setAttributedTitle(NSAttributedString(string: "Choose size", attributes: [
            NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 10),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]), for: .normal)
        return button
    } ()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .orange
        label.isHidden = true
        label.layer.cornerRadius = 8
        label.text = "\(count)"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = MontserratFont.makefont(name: .semibold, size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    
    
    
}

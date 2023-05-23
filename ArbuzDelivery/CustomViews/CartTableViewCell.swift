import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func addProductToCart(product: ProductModel)
    func removeProductFromCart(product: ProductModel)
}

final class CartTableViewCell: UITableViewCell {
    
    weak var delegate: CartTableViewCellDelegate?
    
    var product: ProductCartModel? {
        didSet {
            guard let product = product else {
                return
            }
            image.image = UIImage(named: "\(product.product.imageLink)" )
            let price = String(format: "%.2f", (product.product.price * Float(product.count)) )
            priceLabel.text = "$"+price
            nameLabel.text = product.product.name
            countLabel.text = "$\(product.product.price)x\(product.count)"
            massLabel.text = "\(Int(product.product.amount)*product.count) " + product.product.unit
            amountLabel.text = "\(Int(product.product.amount)) " + product.product.unit
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupCell()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 15
    }
    
    func setupCell() {
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(removeButton)
        contentView.addSubview(amountLabel)
        contentView.addSubview(massLabel)
        contentView.addSubview(editButton)
        self.addSubview(countLabel)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeButtonAction), for: .touchUpInside)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10.0),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
            
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 150.0),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            
            amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            amountLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),

            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            
            countLabel.rightAnchor.constraint(equalTo: priceLabel.rightAnchor),
            countLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            
            massLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            massLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            addButton.heightAnchor.constraint(equalToConstant: 37),
            addButton.widthAnchor.constraint(equalToConstant: 37),
            addButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            removeButton.heightAnchor.constraint(equalToConstant: 30),
            removeButton.widthAnchor.constraint(equalToConstant: 30),
            removeButton.rightAnchor.constraint(equalTo: addButton.leftAnchor),
            removeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            
            editButton.heightAnchor.constraint(equalToConstant: 35),
            editButton.widthAnchor.constraint(equalToConstant: 35),
            editButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -13),
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            
           
        ])
    }
    
    func version() {
        addButton.isHidden = true
        removeButton.isHidden = true
        editButton.isHidden = false
    }
    
    @objc func addButtonAction() {
        guard let product = product else {
            return
        }
        delegate?.addProductToCart(product: product.product)
    }
    
    @objc func removeButtonAction() {
        guard let product = product else {
            return
        }
        delegate?.removeProductFromCart(product: product.product)
    }
    
    lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "" ))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    } ()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = MontserratFont.makefont(name: .semibold, size: 18)
        return label
    } ()
    
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        label.font = MontserratFont.makefont(name: .bold, size: 24)
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
        label.text = "250 grams"
        label.font = MontserratFont.makefont(name: .semibold, size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setBackgroundImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    } ()
    
    
    lazy var massLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = MontserratFont.makefont(name: .semibold, size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = MontserratFont.makefont(name: .semibold, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    
    
}

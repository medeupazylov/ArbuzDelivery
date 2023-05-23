import UIKit

class SubscriptionTableViewCell: UITableViewCell {
    
    var subscription: SubscriptModel? {
        didSet {
            updateCell()
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
    
    func updateCell() {
        guard let subscription = subscription else {
            return
        }
        nameLabel.text = subscription.title
        let days = ["MON","TUE","WED","THU","FRI","SAT","SUN"]
        let arr = subscription.date.days
        var string = ""
        for i in 0..<arr.count {
            if arr[i] == true {
                if(string != "") {
                    string = string + " | "
                }
                string = string + days[i]
            }
        }
        deliveryTitle.text = string
        deliveryInfo.text = "between [\(subscription.date.time)]"
        countLabel.text = "\(subscription.cart.count) products"
        
        var cost: Float = 0
        for item in subscription.cart {
            cost = cost + (Float(item.count) * item.product.price)
        }
        priceLabel.text = "$" + String(format: "%.2f", cost)
        
    }
    
    func setupCell() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(deliveryInfo)
        contentView.addSubview(deliveryTitle)
        contentView.addSubview(line)
        contentView.addSubview(countLabel)
        
//        let newSize = CGSize(width: (self.bounds.width), height: 100)
//        let newOrigin = CGPoint(x: 16, y: 0)
//        let backgroundView = UIView()
//        backgroundView.layer.cornerRadius = 18.0
//        backgroundView.frame = CGRect(origin: newOrigin, size: newSize)
//        backgroundView.backgroundColor = .orange
//
//        self.backgroundView?.backgroundColor = .white
//
//        let view = UIView()
//        self.selectedBackgroundView = view
//
//        let selectedBackgroundView = UIView()
//        selectedBackgroundView.backgroundColor = .systemGray3
//        selectedBackgroundView.layer.cornerRadius = 18.0
//        selectedBackgroundView.frame = CGRect(origin: newOrigin, size: newSize)
//        self.selectedBackgroundView!.addSubview(selectedBackgroundView)

    
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10.0),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0),
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),

            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            
            countLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0),
            countLabel.heightAnchor.constraint(equalToConstant: 45),
            countLabel.widthAnchor.constraint(equalToConstant: 120),
            
            deliveryTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            deliveryTitle.bottomAnchor.constraint(equalTo: deliveryInfo.topAnchor, constant: -5),
            deliveryInfo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            deliveryInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            line.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            line.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            line.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            line.heightAnchor.constraint(equalToConstant: 1.5),
            
           
        ])
    }
    
    
    let deliveryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MON | TUE | FRI"
        label.font = MontserratFont.makefont(name: .semibold, size: 15)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()
    
    let deliveryInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "between [9.00-12.00]"
        label.font = MontserratFont.makefont(name: .semibold, size: 15)
        label.textColor = .systemGray
        return label
    } ()
    
    let line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    } ()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My favorite fresh food"
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        return label
    } ()
    
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$39.11"
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        label.font = MontserratFont.makefont(name: .bold, size: 25)
        return label
    } ()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 15
        label.text = "14 products"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = MontserratFont.makefont(name: .semibold, size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
}

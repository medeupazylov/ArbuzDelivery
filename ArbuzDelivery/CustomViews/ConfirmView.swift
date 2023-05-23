import UIKit

class ConfirmView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(nameField)
        self.addSubview(deliveryInfo)
        self.addSubview(deliveryTitle)
        self.addSubview(periodInfo)
        self.addSubview(periodTitle)
        self.addSubview(addressTitle)
        self.addSubview(addressInfo)
        self.addSubview(line)
        self.addSubview(costLabel)
    }
    
    func addDelegateToTextField(view: SubscriptView) {
        nameField.textField.delegate = view
    }
    
    func updateInfo(dateInfo: DateModel, address: AddressModel, totalCost: Float) {
        let days = ["MON","TUE","WED","THU","FRI","SAT","SUN"]
        let arr = dateInfo.days
        var string = ""
        for i in 0..<arr.count {
            if arr[i] == true {
                if(string != "") {
                    string = string + " | "
                }
                string = string + days[i]
            }
        }
        string = string + " between [\(dateInfo.time)]"
        deliveryInfo.text = string
        
        periodInfo.text = dateInfo.period
        addressInfo.text = "\(address.street) \(address.house). Apartment \(address.apartment)"

        costLabel.text = "$" + String(format: "%.2f", totalCost)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            nameField.leftAnchor.constraint(equalTo: self.leftAnchor),
            nameField.rightAnchor.constraint(equalTo: self.rightAnchor),
            nameField.topAnchor.constraint(equalTo: self.topAnchor),
            
            deliveryTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            deliveryTitle.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15),
            deliveryInfo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            deliveryInfo.topAnchor.constraint(equalTo: deliveryTitle.bottomAnchor, constant: 4),
            
            periodTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            periodTitle.topAnchor.constraint(equalTo: deliveryInfo.bottomAnchor, constant: 14),
            periodInfo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            periodInfo.topAnchor.constraint(equalTo: periodTitle.bottomAnchor, constant: 4),
            
            addressTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            addressTitle.topAnchor.constraint(equalTo: periodInfo.bottomAnchor, constant: 14),
            addressInfo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            addressInfo.topAnchor.constraint(equalTo: addressTitle.bottomAnchor, constant: 4),
            
            line.leftAnchor.constraint(equalTo: self.leftAnchor),
            line.rightAnchor.constraint(equalTo: self.rightAnchor),
            line.topAnchor.constraint(equalTo: addressInfo.bottomAnchor, constant: 10),
            line.heightAnchor.constraint(equalToConstant: 3.0),
            
            costLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            costLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5),
            
        ])
    }
    
    let nameField: CustomTextField = {
        let field = CustomTextField(placeHolder: "Name your subscription", centered: false, required: true)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    } ()
    
    let deliveryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Delivery time:"
        label.font = MontserratFont.makefont(name: .semibold, size: 14)
        label.textColor = .systemGray
        return label
    } ()
    
    let deliveryInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MON | TUE | FRI      between [9.00-12.00]"
        label.font = MontserratFont.makefont(name: .semibold, size: 14)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()
    
    let periodTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Delivery period:"
        label.font = MontserratFont.makefont(name: .semibold, size: 14)
        label.textColor = .systemGray
        return label
    } ()
    
    let periodInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4 weeks"
        label.font = MontserratFont.makefont(name: .semibold, size: 14)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()
    
    let addressTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Address:"
        label.font = MontserratFont.makefont(name: .semibold, size: 14)
        label.textColor = .systemGray
        return label
    } ()
    
    let addressInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bauyrzhan Momyshuly 4. Apartment 129"
        label.font = MontserratFont.makefont(name: .semibold, size: 14)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()
    
    let line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    } ()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$31.43"
        label.font = MontserratFont.makefont(name: .bold, size: 22)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()
    
}

import UIKit

class CustomTextField: UIView {
    
    let required: Bool
    
    init(placeHolder: String, centered: Bool, required: Bool) {
        self.required = required
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.layer.cornerRadius = 18.0
        self.backgroundColor = .systemGray5
        self.addSubview(textField)
        self.addSubview(star)
        
        textField.placeholder = placeHolder
        if centered {
            textField.textAlignment = .center
            setupLayoutCentered()
        } else {
            setupLayout()
        }
        
        star.isHidden = !(required)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayoutCentered() {
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            star.heightAnchor.constraint(equalToConstant: 8),
            star.widthAnchor.constraint(equalToConstant: 8),
            star.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            star.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])
    }
    
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            star.heightAnchor.constraint(equalToConstant: 8),
            star.widthAnchor.constraint(equalToConstant: 8),
            star.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            star.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])
    }
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        textField.font = MontserratFont.makefont(name: .semibold, size: 16)
        return textField
    } ()
    
    let star: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "staroflife.fill"))
        img.tintColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    } ()
    
}

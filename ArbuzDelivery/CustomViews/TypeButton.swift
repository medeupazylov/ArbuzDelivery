import UIKit

class TypeButton: UIButton {
    
    var isChosen: Bool = false {
        didSet {
            
        }
    }
    
    let titleText: String
    let imgName: UIImage
    
    init(titleText: String, img: UIImage) {
        self.titleText = titleText
        self.imgName = img
        super.init(frame: .zero)
        self.layer.cornerRadius = 10.0
//        self.layer.borderWidth = 1.0
        setupViews()
        setupLayout()
//        self.setImage(img, for: .normal)
//        self.setAttributedTitle(NSAttributedString(string: titleText, attributes: [
//            NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 10)
//        ]), for: .normal)
//        configureButton()
    }
    
    func setupViews() {
        self.addSubview(stackContainer)
        stackContainer.addArrangedSubview(icon)
        stackContainer.addArrangedSubview(label)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 35),
            stackContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            stackContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            stackContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            icon.widthAnchor.constraint(equalToConstant: 22),
            icon.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    lazy var icon: UIImageView = {
        let img = UIImageView(image: imgName)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    } ()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = titleText
        label.textColor = .black
    
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        return label
    } ()
    
    
}

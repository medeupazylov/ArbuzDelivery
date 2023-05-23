import UIKit

class SectionView: UIView {
    
    let sectionTitle: String
    let sectionLogo: UIImage
    private let addActionClosure: ((ProductModel) -> Void)?
    private let removeActionClosure: ((ProductModel) -> Void)?
    private let getCountActionClosure: ((ProductModel) -> Int)?
    private let chooseSizeActionClosure: ((ProductModel) -> Void)?
    
    init(title: String, image: UIImage, addAction: ((ProductModel) -> Void)?, removeAction: ((ProductModel) -> Void)?, getCountAction: ((ProductModel) -> Int)?, chooseSizeAction: ((ProductModel) -> Void)?) {
        self.addActionClosure = addAction
        self.removeActionClosure = removeAction
        self.getCountActionClosure = getCountAction
        self.chooseSizeActionClosure = chooseSizeAction
        self.sectionLogo = image
        self.sectionTitle = title
        super.init(frame: .zero)
        setupView()
        setupLayout()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadDataToCards(data: [ProductModel]) {
        for item in data{
            let productCard = ProductCardView(product: item, addAction: addActionClosure, removeAction: removeActionClosure, getCountAction: getCountActionClosure, chooseSizeAction: chooseSizeActionClosure)
            stack.addArrangedSubview(productCard)
        }
    }
    
    private func setupView() {
        self.addSubview(fruitsButton)
        self.addSubview(line)
        self.addSubview(scroll)
        scroll.addSubview(stack)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 290),
            fruitsButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            fruitsButton.topAnchor.constraint(equalTo: self.topAnchor),
            
            scroll.topAnchor.constraint(equalTo: fruitsButton.bottomAnchor, constant: 10.0),
            scroll.leftAnchor.constraint(equalTo: self.leftAnchor),
            scroll.rightAnchor.constraint(equalTo: self.rightAnchor),
            scroll.bottomAnchor.constraint(equalTo: fruitsButton.bottomAnchor, constant: 230.0),

            
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.leftAnchor.constraint(equalTo: scroll.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: scroll.rightAnchor, constant: -10),
            
            line.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            line.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10),
            line.topAnchor.constraint(equalTo: fruitsButton.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 2.0)
            
        ])
    }
    
    func updateProductCount() {
        for view in stack.arrangedSubviews {
            guard let view = view as? ProductCardView else {return}
            view.updateProductCount()
        }
    }
    
    let line: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        line.layer.cornerRadius = 1.0
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .orange
        return line
    } ()
    
    lazy var fruitsButton: TypeButton = {
        let button = TypeButton(titleText: sectionTitle, img: sectionLogo)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    } ()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10.0
        stack.distribution = .equalSpacing
        return stack
    } ()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.red.cgColor,
            UIColor.purple.cgColor,
            UIColor.cyan.cgColor
        ]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()
    
}

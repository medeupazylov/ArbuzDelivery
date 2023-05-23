import UIKit



class DayButton: UIButton {
    
    var didSelect = false {
        didSet {
            if didSelect == true {
                self.backgroundColor = .orange
                self.setAttributedTitle(NSAttributedString(string: (self.attributedTitle(for: .normal)?.string)!, attributes: [
                    NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 12),
                    NSAttributedString.Key.foregroundColor : UIColor.white
                ]), for: .normal)
            } else {
                self.backgroundColor = .systemGray5
                self.setAttributedTitle(NSAttributedString(string: (self.attributedTitle(for: .normal)?.string)!, attributes: [
                    NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 12),
                    NSAttributedString.Key.foregroundColor : UIColor.systemGray
                ]), for: .normal)
            }
        }
    }
    
    
    init(text: String) {
        super.init(frame: .zero)
        self.setAttributedTitle(NSAttributedString(string: text, attributes: [
            NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 12),
            NSAttributedString.Key.foregroundColor : UIColor.systemGray
        ]), for: .normal)
        self.backgroundColor = .systemGray5
        self.tintColor = .black
        self.layer.cornerRadius = 15
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupSize1() {
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.widthAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupSize2() {
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

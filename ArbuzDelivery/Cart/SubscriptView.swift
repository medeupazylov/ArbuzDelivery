import UIKit

enum subscriptState {
    case daySelection
    case periodSelection
    case addressTyping
    case confirming
}

class SubscriptView: UIViewController {
    
    weak var cartView: CartViewProtocol?
    
    private let days = ["MON","TUE","WED","THU","FRI","SAT","SUN"]
    private var daysSelected = [false,false,false,false,false,false,false]
    
    private let times = ["9:00-12:00","12:00-15:00","15:00-18:00","18:00-21:00"]
    private var timeSelectedIndex = 0
    
    private let weeks = ["1 week", "2 weeks","3 weeks","4 weeks","5 weeks","6 weeks","7 weeks","8 weeks","9 weeks"]
    private var weekSelectedIndex = 1
    
    private var confirmActionClosure: ((SubscriptModel)->Void)?
    
    private var state: subscriptState = .daySelection {
        didSet {
            returnTextFields()
            hideAllViews()
            updateState()
        }
    }
    
    init(confirmActionClosure: ((SubscriptModel)->Void)?) {
        self.confirmActionClosure = confirmActionClosure
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupStack()
        view.backgroundColor = .systemGray6
        periodPicker.dataSource = self
        periodPicker.delegate = self
    }
    
    
    private func setupViews() {
        view.addSubview(dayTitle)
        view.addSubview(timeTitle)
        view.addSubview(dayStack)
        view.addSubview(timeStack)
        view.addSubview(continueButton)
        view.addSubview(backButton)
        view.addSubview(dayMessageLabel)
        view.addSubview(periodTitle)
        view.addSubview(periodPicker)
        view.addSubview(addressTitle)
        view.addSubview(addressView)
        view.addSubview(addressMessageLabel)
        view.addSubview(confirmTitle)
        view.addSubview(confirmView)

        continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            dayTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dayTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        
            dayStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dayStack.topAnchor.constraint(equalTo: dayTitle.bottomAnchor, constant: 15),
            dayStack.heightAnchor.constraint(equalToConstant: 50),
            
            timeTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            timeTitle.topAnchor.constraint(equalTo: dayStack.bottomAnchor, constant: 30),
            
            timeStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeStack.topAnchor.constraint(equalTo: timeTitle.bottomAnchor, constant: 15),
            timeStack.heightAnchor.constraint(equalToConstant: 50),
            
            periodTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            periodTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            continueButton.heightAnchor.constraint(equalToConstant: 55),
            continueButton.widthAnchor.constraint(equalToConstant: 180),
            
            backButton.rightAnchor.constraint(equalTo: continueButton.leftAnchor, constant: -20),
            backButton.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 55),
            
            dayMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dayMessageLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
            
            addressMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressMessageLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
            
            periodPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            periodPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            periodPicker.heightAnchor.constraint(equalToConstant: 200),
            periodPicker.widthAnchor.constraint(equalToConstant: 200),
            
            addressTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            addressTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            addressView.topAnchor.constraint(equalTo: addressTitle.bottomAnchor, constant: 20),
            addressView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            addressView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addressView.heightAnchor.constraint(equalTo: addressTitle.heightAnchor, constant: 200),
            
            confirmTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            confirmTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            confirmView.topAnchor.constraint(equalTo: addressTitle.bottomAnchor, constant: 20),
            confirmView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            confirmView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            confirmView.heightAnchor.constraint(equalTo: addressTitle.heightAnchor, constant: 250),
        ])
    }
    
    private func setupConfirmView() {
        let date = DateModel(days: daysSelected, time: times[timeSelectedIndex-1], period: weeks[weekSelectedIndex-1])
        let address = addressView.getAddressInfo()
        let cost = cartView?.getTotalCost()
        confirmView.updateInfo(dateInfo: date, address: address, totalCost: cost!)
    }
    
    private func updateState() {
        if state == .daySelection {
            dayTitle.isHidden = false
            dayStack.isHidden = false
            timeTitle.isHidden = false
            timeStack.isHidden = false
        }
        if state == .periodSelection {
            backButton.isHidden = false
            periodTitle.isHidden = false
            periodPicker.isHidden = false
        }
        if state == .addressTyping {
            addressTitle.isHidden = false
            addressView.isHidden = false
            backButton.isHidden = false
        }
        if state == .confirming {
            backButton.isHidden = false
            continueButton.setAttributedTitle(NSAttributedString(string: "Confirm", attributes: [
                NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 18),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]), for: .normal)
            confirmTitle.isHidden = false
            confirmView.isHidden = false
            setupConfirmView()
        }
    }
    
    private func hideAllViews() {
        dayTitle.isHidden = true
        dayStack.isHidden = true
        timeTitle.isHidden = true
        timeStack.isHidden = true
        dayMessageLabel.isHidden = true
        backButton.isHidden = true
        periodTitle.isHidden = true
        periodPicker.isHidden = true
        periodTitle.isHidden = true
        periodPicker.isHidden = true
        addressTitle.isHidden = true
        addressView.isHidden = true
        addressMessageLabel.isHidden = true
        confirmTitle.isHidden = true
        confirmView.isHidden = true
        continueButton.setAttributedTitle(NSAttributedString(string: "Continue", attributes: [
            NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 18),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]), for: .normal)
    }
    
    private func returnTextFields() {
        let _ = textFieldShouldReturn(addressView.streetField.textField)
        let _ = textFieldShouldReturn(addressView.houseField.textField)
        let _ = textFieldShouldReturn(addressView.apartmentField.textField)
        let _ = textFieldShouldReturn(addressView.floorField.textField)
        let _ = textFieldShouldReturn(addressView.entryField.textField)
        let _ = textFieldShouldReturn(addressView.phoneNumberField.textField)
        let _ = textFieldShouldReturn(confirmView.nameField.textField)
    }
    
    private func setupStack() {
        for day in days {
            let dayButton = DayButton(text: day)
            dayButton.addTarget(self, action: #selector(dayButtonAction), for: .touchUpInside)
            dayButton.setupSize1()
            dayStack.addArrangedSubview(dayButton)
        }
        for time in times {
            let timeButton = DayButton(text: time)
            timeButton.addTarget(self, action: #selector(timeButtonAction), for: .touchUpInside)
            timeButton.setupSize2()
            timeStack.addArrangedSubview(timeButton)
        }
    }
    
    @objc private func dayButtonAction(_ sender: DayButton?) {
        guard let sender = sender else {
            return
        }
        
        sender.didSelect = !(sender.didSelect)
        guard let title = sender.attributedTitle(for: .normal)?.string else {return}
        for i in 0..<days.count {
            if(title == days[i]) {
                daysSelected[i] = !(daysSelected[i])
            }
        }
        print(daysSelected)

    }
    
    @objc private func timeButtonAction(_ sender: DayButton?) {
        guard let sender = sender else {
            return
        }
        
        for button in timeStack.arrangedSubviews {
            guard let button = button as? DayButton else {return}
            button.didSelect = false
        }
        
        guard let title = sender.attributedTitle(for: .normal)?.string else {return}
        for i in 0..<times.count {
            if times[i] == title {
                timeSelectedIndex = i+1
            }
        }
        print(timeSelectedIndex)
        sender.didSelect = true

    }
    
    @objc private func backButtonAction() {
        if state == .periodSelection {
            state = .daySelection
        }
        if state == .addressTyping {
            state = .periodSelection
        }
        if state == .confirming {
            state = .addressTyping
        }
    }
    
    @objc private func continueButtonAction() {
        if state == .daySelection {
            daySelectionAction()
        } else
        if state == .periodSelection {
            state = .addressTyping
        } else
        if state == .addressTyping {
            addressTypingAction()
        } else
        if state == .confirming {
            confirmingAction()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func confirmingAction() {
        let title = confirmView.nameField.textField.text!
        let date = DateModel(days: daysSelected, time: times[timeSelectedIndex-1], period: weeks[weekSelectedIndex-1])
        let address = addressView.getAddressInfo()
        let model = SubscriptModel(title: title, cart: [], date: date, address: address)
        confirmActionClosure?(model)
    }
    
    private func addressTypingAction() {
        if (addressView.infoIsFilled()==false) {
            if addressMessageLabel.isHidden == true {
                addressMessageLabel.isHidden = false
            } else {
                self.addressMessageLabel.font = MontserratFont.makefont(name: .semibold, size: 17)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.addressMessageLabel.font = MontserratFont.makefont(name: .semibold, size: 15)
                }
            }
        } else {
            state = .confirming
        }
    }
    
    private func daySelectionAction() {
        var bool = false
        for item in daysSelected {
            if item == true {
                bool = true
            }
        }
        if (bool == false || timeSelectedIndex == 0) {
            if dayMessageLabel.isHidden == true {
                dayMessageLabel.isHidden = false
            } else {
                self.dayMessageLabel.font = MontserratFont.makefont(name: .semibold, size: 17)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.dayMessageLabel.font = MontserratFont.makefont(name: .semibold, size: 15)
                }
            }
        } else {
            state = .periodSelection
        }
    }
    
    
    private lazy var addressView: AddressView = {
        let view = AddressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.addDelegateToTextFields(view: self)
        return view
    } ()
    
    private let periodPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.isHidden = true
        return picker
    } ()
    
    private let dayTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select delivery day"
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()
    
    private let dayStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 5.0
        return stack
    } ()
    
    private let timeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select delivery time"
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()
    
    private let timeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10.0
        return stack
    } ()
    
    private let periodTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select the period for delivery"
        label.isHidden = true
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()
    
    private let addressTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your address and number"
        label.isHidden = true
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()

    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.layer.cornerRadius = 18.0
        button.setAttributedTitle(NSAttributedString(string: "Continue", attributes: [
            NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 18),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]), for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 5
        return button
    } ()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .systemGray2
        button.layer.cornerRadius = 18.0
        button.setAttributedTitle(NSAttributedString(string: "Back", attributes: [
            NSAttributedString.Key.font : MontserratFont.makefont(name: .semibold, size: 15),
            NSAttributedString.Key.foregroundColor : UIColor.systemGray2
        ]), for: .normal)
        button.isHidden = true
        return button
    } ()
    
    private let dayMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You didn't select day or time"
        label.isHidden = true
        label.font = MontserratFont.makefont(name: .semibold, size: 15.0)
        label.textColor = .systemGray
        return label
    } ()
    
    private let addressMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You didn't fill required fields *"
        label.isHidden = true
        label.font = MontserratFont.makefont(name: .semibold, size: 15.0)
        label.textColor = .systemGray
        return label
    } ()
    
    private let confirmTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subscription info"
        label.isHidden = true
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        return label
    } ()
    
    private lazy var confirmView: ConfirmView = {
        let view = ConfirmView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.addDelegateToTextField(view: self)
        return view
    } ()
    
}


extension SubscriptView: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weeks.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = MontserratFont.makefont(name: .semibold, size: 20)
        label.textColor = UIColor(red: 204/255, green: 112/255, blue: 0/255, alpha: 1)
        label.text =  weeks[row]
        label.textAlignment = .center
        return label
    }
}

extension SubscriptView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.weekSelectedIndex = row + 1
        print(self.weekSelectedIndex)
    }
}

extension SubscriptView: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
          return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return false
    }
}

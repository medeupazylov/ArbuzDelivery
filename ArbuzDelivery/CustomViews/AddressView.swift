import UIKit
import CloudKit

class AddressView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(streetField)
        self.addSubview(houseField)
        self.addSubview(apartmentField)
        self.addSubview(entryField)
        self.addSubview(floorField)
        self.addSubview(phoneNumberField)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            streetField.leftAnchor.constraint(equalTo: self.leftAnchor),
            streetField.rightAnchor.constraint(equalTo: houseField.leftAnchor, constant: -15),
            streetField.topAnchor.constraint(equalTo: self.topAnchor),
            
            houseField.widthAnchor.constraint(equalToConstant: 90),
            houseField.rightAnchor.constraint(equalTo: self.rightAnchor),
            houseField.topAnchor.constraint(equalTo: self.topAnchor),
//
            apartmentField.leftAnchor.constraint(equalTo: self.leftAnchor),
            apartmentField.rightAnchor.constraint(equalTo: entryField.leftAnchor, constant: -15),
            apartmentField.topAnchor.constraint(equalTo: streetField.bottomAnchor, constant: 30),
//
            entryField.widthAnchor.constraint(equalToConstant: 90),
            entryField.rightAnchor.constraint(equalTo: floorField.leftAnchor, constant: -15),
            entryField.topAnchor.constraint(equalTo: streetField.bottomAnchor, constant: 30),
//
            floorField.widthAnchor.constraint(equalToConstant: 90),
            floorField.rightAnchor.constraint(equalTo: self.rightAnchor),
            floorField.topAnchor.constraint(equalTo: streetField.bottomAnchor, constant: 30),
            
            phoneNumberField.leftAnchor.constraint(equalTo: self.leftAnchor),
            phoneNumberField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -105),
            phoneNumberField.topAnchor.constraint(equalTo: floorField.bottomAnchor, constant: 30),
        
        ])
    }
    
    func getAddressInfo() -> AddressModel {
        let number = phoneNumberField.textField.text!
        let street = streetField.textField.text!
        let house = (houseField.textField.text! as NSString).integerValue
        let apartment = (apartmentField.textField.text! as NSString).integerValue
        let entry: Int? = (entryField.textField.text! as NSString).integerValue
        let floor: Int? = (floorField.textField.text! as NSString).integerValue
        return AddressModel(phoneNumber: number, street: street, house: house, apartment: apartment, entry: entry, floor: floor)
    }
    
    func addDelegateToTextFields(view: SubscriptView) {
        streetField.textField.delegate = view
        houseField.textField.delegate = view
        apartmentField.textField.delegate = view
        entryField.textField.delegate = view
        floorField.textField.delegate = view
        phoneNumberField.textField.delegate = view
    }
    
    func infoIsFilled() -> Bool {
        if (streetField.textField.text == "" ||
            houseField.textField.text == "" ||
            apartmentField.textField.text == "" ||
            phoneNumberField.textField.text == "") {
            return false
        }
        return true
    }
    
    let streetField: CustomTextField = {
        let field = CustomTextField(placeHolder: "Street", centered: false, required: true)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    } ()
    
    let houseField: CustomTextField = {
        let field = CustomTextField(placeHolder: "House", centered: true, required: true)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    } ()
    
    let apartmentField: CustomTextField = {
        let field = CustomTextField(placeHolder: "Apartment", centered: true, required: true)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    } ()
    
    let entryField: CustomTextField = {
        let field = CustomTextField(placeHolder: "Entry", centered: true, required: false)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    } ()
    
    let floorField: CustomTextField = {
        let field = CustomTextField(placeHolder: "Floor", centered: true, required: false)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    } ()
    
    let phoneNumberField: CustomTextField = {
        let field = CustomTextField(placeHolder: "Phone Number: +7", centered: false, required: true)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    } ()
    
    
}

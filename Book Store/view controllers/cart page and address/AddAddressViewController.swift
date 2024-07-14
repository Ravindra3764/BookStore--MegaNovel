import UIKit
import FirebaseFirestore

protocol AddAddressViewControllerDelegate: AnyObject {
    func clearCart()
}

class AddAddressViewController: UIViewController {
     
    weak var delegate: AddAddressViewControllerDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var pinCodeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var localityTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var addAddressButton: UIButton!
    @IBOutlet weak var cashOnDeliveryLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!

    let cashOnDeliveryButton = UIButton(type: .custom)
    let otherButton = UIButton(type: .custom)
    let successLabel = UILabel()
    
    var cartItems: [CartItem] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        // Set up cashOnDeliveryButton
        cashOnDeliveryButton.setImage(UIImage(systemName: "circle"), for: .normal)
        cashOnDeliveryButton.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        cashOnDeliveryButton.addTarget(self, action: #selector(paymentOptionTapped(_:)), for: .touchUpInside)

        // Set up otherButton
        otherButton.setImage(UIImage(systemName: "circle"), for: .normal)
        otherButton.setImage(UIImage(systemName: "circle"), for: .selected) // Same image to indicate disabled state
        otherButton.addTarget(self, action: #selector(paymentOptionTapped(_:)), for: .touchUpInside)
        otherButton.isEnabled = false // Always disabled

        // Set up labels
        cashOnDeliveryLabel.text = "Cash On Delivery"
        otherLabel.text = "Other"
        otherLabel.textColor = .gray // Change color to indicate disabled state
        otherButton.isEnabled = false // Disable the "Other" button

        // Set up placeOrderButton
        placeOrderButton.setTitle("Place Order", for: .normal)
        placeOrderButton.addTarget(self, action: #selector(placeOrderTapped), for: .touchUpInside)
        placeOrderButton.isEnabled = false // Disable initially

        // Set up successLabel
        successLabel.text = ""
        successLabel.textColor = .black
        successLabel.textAlignment = .center

        // Add to view
        [cashOnDeliveryButton, otherButton, cashOnDeliveryLabel, otherLabel, successLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        // Constraints
        NSLayoutConstraint.activate([
            // Position the buttons and labels below the addAddressButton
            cashOnDeliveryButton.topAnchor.constraint(equalTo: addAddressButton.bottomAnchor, constant: 20),
            cashOnDeliveryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            cashOnDeliveryLabel.centerYAnchor.constraint(equalTo: cashOnDeliveryButton.centerYAnchor),
            cashOnDeliveryLabel.leadingAnchor.constraint(equalTo: cashOnDeliveryButton.trailingAnchor, constant: 10),

            otherButton.topAnchor.constraint(equalTo: cashOnDeliveryButton.bottomAnchor, constant: 10),
            otherButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            otherLabel.centerYAnchor.constraint(equalTo: otherButton.centerYAnchor),
            otherLabel.leadingAnchor.constraint(equalTo: otherButton.trailingAnchor, constant: 10),

            placeOrderButton.topAnchor.constraint(equalTo: otherButton.bottomAnchor, constant: 20),
            placeOrderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            successLabel.topAnchor.constraint(equalTo: placeOrderButton.bottomAnchor, constant: 20),
            successLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func paymentOptionTapped(_ sender: UIButton) {
        // Toggle selection state of the sender button
        sender.isSelected.toggle()

        // Deselect the other button if the current button is selected
        if sender == cashOnDeliveryButton {
            otherButton.isSelected = false
        } else if sender == otherButton {
            cashOnDeliveryButton.isSelected = false
        }
    }

    @objc func placeOrderTapped() {
        if cashOnDeliveryButton.isSelected {
            saveOrderToFirebase()
        } else {
            successLabel.text = "Please select a payment method."
        }
    }

    func validateFields() -> Bool {
        // Check if all required fields are filled
        let isNameValid = !(nameTextField.text?.isEmpty ?? true)
        let isMobileNumberValid = isValidPhoneNumber(mobileNumberTextField.text)
        let isPinCodeValid = isValidPinCode(pinCodeTextField.text)
        let isAddressValid = !(addressTextField.text?.isEmpty ?? true)
        let isLocalityValid = !(localityTextField.text?.isEmpty ?? true)
        let isCityValid = !(cityTextField.text?.isEmpty ?? true)
        let isStateValid = !(stateTextField.text?.isEmpty ?? true)

        return isNameValid && isMobileNumberValid && isPinCodeValid && isAddressValid && isLocalityValid && isCityValid && isStateValid
    }

    func isValidPhoneNumber(_ phoneNumber: String?) -> Bool {
        guard let phoneNumber = phoneNumber else { return false }
        let phoneRegex = "^[0-9]{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }

    func isValidPinCode(_ pinCode: String?) -> Bool {
        guard let pinCode = pinCode else { return false }
        let pinCodeRegex = "^[0-9]{6}$"
        let pinCodeTest = NSPredicate(format: "SELF MATCHES %@", pinCodeRegex)
        return pinCodeTest.evaluate(with: pinCode)
    }

    @IBAction func addAddressButtonTapped(_ sender: UIButton) {
        if validateFields() {
            // Enable the radio buttons and continue button
            cashOnDeliveryButton.isEnabled = true
            otherButton.isEnabled = true
            placeOrderButton.isEnabled = true

            // Save to Firebase
            saveAddressToFirebase()
        } else {
            // Show an alert if validation fails
            let alert = UIAlertController(title: "Validation Error", message: "Please fill all the fields correctly.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func backAddVC(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    func saveAddressToFirebase() {
        guard let name = nameTextField.text,
              let mobileNumber = mobileNumberTextField.text,
              let pinCode = pinCodeTextField.text,
              let address = addressTextField.text,
              let locality = localityTextField.text,
              let city = cityTextField.text,
              let state = stateTextField.text else {
            return
        }

        let db = Firestore.firestore()
        db.collection("addresses").addDocument(data: [
            "name": name,
            "mobileNumber": mobileNumber,
            "pinCode": pinCode,
            "address": address,
            "locality": locality,
            "city": city,
            "state": state
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully added in orders database")
            }
        }
    }

    func saveOrderToFirebase() {
        guard let name = nameTextField.text,
              let mobileNumber = mobileNumberTextField.text,
              let pinCode = pinCodeTextField.text,
              let address = addressTextField.text,
              let locality = localityTextField.text,
              let city = cityTextField.text,
              let state = stateTextField.text else {
            return
        }

        let db = Firestore.firestore()
        let batch = db.batch()
        let paymentMethod = "Cash On Delivery"

        for item in cartItems {
            let newOrderRef = db.collection("myorders").document()
            let orderData: [String: Any] = [
                "title": item.title,
                "author": item.author,
                "price": item.price,
                "description": item.description,
                "imageUrl": item.imageUrl,
                "address": [
                    "name": name,
                    "mobileNumber": mobileNumber,
                    "pinCode": pinCode,
                    "address": address,
                    "locality": locality,
                    "city": city,
                    "state": state
                ],
                "paymentMethod": paymentMethod,
                "orderDate": Timestamp(date: Date())
            ]
            batch.setData(orderData, forDocument: newOrderRef)

            let cartRef = db.collection("cart").document(item.id)
            batch.deleteDocument(cartRef)
        }

        batch.commit { [weak self] error in
            if let error = error {
                print("Error placing order: \(error)")
                self?.successLabel.text = "Error placing order"
            } else {
                print("Order placed successfully!")
                self?.successLabel.text = "Order placed successfully!"
                self?.delegate?.clearCart()
            }
        }
    }
}

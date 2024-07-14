import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class edit_VC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var img_add: UIImageView!
    @IBOutlet weak var dp_dob: UITextField!
    
    var uid: String?
    
    @IBOutlet weak var TF_name: UITextField!
    @IBOutlet weak var TF_email: UITextField!
    @IBOutlet weak var TF_phone: UITextField!
    @IBOutlet weak var TF_pass: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser {
            uid = currentUser.uid
         } else {
            print("No user is signed in")
        }
        
        setupUI()
    }
    
    func setupUI() {
        let imgwidth = img_add.frame.size.width
        img_add.layer.cornerRadius = imgwidth / 2
        img_add.clipsToBounds = true
        img_add.layer.masksToBounds = true
        img_add.contentMode = .scaleAspectFill
        img_add.layer.borderWidth = 2.0
        img_add.layer.borderColor = UIColor.white.cgColor
        
        img_add.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(imgtapped))
        img_add.addGestureRecognizer(tapgesture)
        
        self.dp_dob.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
        if let datepicker = self.dp_dob.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.dp_dob.text = dateformatter.string(from: datepicker.date)
        }
        self.dp_dob.resignFirstResponder()
    }
    
    @IBAction func act_cancel(_ sender: UIButton) {
        clearTextFields()
        self.navigationController?.popViewController(animated: true)
    }
    
 
    func updataUserData(documentID: String, name: String, email: String, PhoneNumber: String, password: String) {
        
        let userRef =  db.collection("user").document(documentID)
        
        userRef.updateData( [
        
            "name": name,
            "email": email,
            "PhoneNumber": PhoneNumber,
            "password": password

        ]){err in
            if let err = err{
                print("Error updating document:", err.localizedDescription)
            }else{
                print("Document successfully updated")
            }

            
        }
    
    }
    @IBAction func act_save(_ sender: UIButton) {
        guard let username = self.TF_name.text, !username.isEmpty,
              let email = self.TF_email.text, !email.isEmpty,
              let phoneno = self.TF_phone.text, !phoneno.isEmpty,
              let password = self.TF_pass.text, !password.isEmpty,
              let date = self.dp_dob.text, !date.isEmpty
            else {
            showAlert(title: "ERROR", message: "Please Fill The Entry")
            return
        }
        
        if password.count < 6 {
            showAlert(title: "ERROR", message: "Password must be 6 characters long.")
            return
        }
        
        guard email.isValidEmail() else {
            showAlert(title: "ERROR", message: "Invalid Email")
            return
        }
        
        guard phoneno.isValidPhoneNumber() else {
            showAlert(title: "ERROR", message: "Invalid Phone number.")
            return
        }
        
       let documentID = uid  // here uid will be changed to User_id that is from userdefaults from login page
        let newName = self.TF_name.text ?? ""
        let newEmail = self.TF_email.text ?? ""
        let newPassword = self.TF_pass.text ?? ""
        let newphone = self.TF_phone.text ?? ""
        
        updataUserData(documentID: "documentID", name: newName, email: newEmail, PhoneNumber: newphone, password: newPassword)
 
        showAlert(title: "Saved", message: "Successfully saved information")
        self.navigationController?.popViewController(animated: true)
    }
    
    
     
    
    
     
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearTextFields() {
        self.TF_name.text = ""
        self.TF_email.text = ""
        self.TF_phone.text = ""
        self.TF_pass.text = ""
        self.dp_dob.text = ""
    }
    
    @objc func imgtapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            img_add.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneRegex = "^\\d{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: self)
    }
}

extension UITextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        self.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        toolbar.backgroundColor = .white
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolbar.setItems([cancelButton, flexible, doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}

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
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser {
            uid = currentUser.uid
         } else {
            print("No user is signed in")
        }
        TF_pass.isEnabled = false
        TF_email.isEnabled = false
        fetchUserData()
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
    
    func updataUserData(documentID: String, name: String, email: String, PhoneNumber: String,DOB: String) {
        let userRef =  db.collection("user").document(documentID)
        
        userRef.updateData( [
            "name": name,
            "Email": email,
            "phoneNumber": PhoneNumber,
            "DOB": DOB
            
         ]) { err in
            if let err = err {
                print("Error updating document:", err.localizedDescription)
            } else {
                print("Document successfully updated")
                
            }
        }
    }
    
    @IBAction func act_save(_ sender: UIButton) {
        guard let username = self.TF_name.text,
              let email = self.TF_email.text,
              let phoneno = self.TF_phone.text,
              let date = self.dp_dob.text  else {
//            showAlert(title: "ERROR", message: "Please Fill The Entry")
            return
        }
        
     
        guard email.isValidEmaill() else {
            showAlert(title: "ERROR", message: "Invalid Email")
            return
        }
        
        guard phoneno.isValidPhoneNumber() else {
            showAlert(title: "ERROR", message: "Invalid Phone number.")
            return
        }
        
        if let uid = uid {
            updataUserData(documentID: uid, name: username, email: email, PhoneNumber: phoneno, DOB: date)
            self.navigationController?.popViewController(animated: true)
            showAlert(title: "Saved", message: "Successfully saved information")
        }
    }
    
    func clearTextFields() {
        self.TF_name.text = ""
        self.TF_email.text = ""
        self.TF_phone.text = ""
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
            if let uid = self.uid {
                uploadImageToFirebase(image: selectedImage, userID: uid)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    func uploadImageToFirebase(image: UIImage, userID: String) {
        let storageRef = storage.reference().child("user_profile_images/\(userID).jpg")
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard let _ = metadata else {
                    print("Error uploading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                // Once uploaded, get the download URL
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("Error fetching download URL: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    
                    // Update Firestore with the download URL
                    self.updateUserProfileImageURL(userID: userID, url: downloadURL.absoluteString)
                }
            }
        }
    }

    func updateUserProfileImageURL(userID: String, url: String) {
        let userRef = db.collection("user").document(userID)
        
        userRef.updateData(["photoURL": url]) { error in
            if let error = error {
                print("Error updating user profile image URL: \(error.localizedDescription)")
            } else {
                print("User profile image URL updated successfully")
            }
        }
    }

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension edit_VC{
    
    func fetchUserData() {
        guard let documentID = uid else {
            print("UID is nil")
            return
        }
        
        db.collection("user").document(documentID).getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            print("Document data: \(String(describing: document.data()))")
            
            
            let data = document.data()
            let name = data?["name"] as? String ?? "No Name"
            let pass = data?["password"] as? String ?? "No pass"
            let email = data?["Email"] as? String ?? "No email"
            let contact_no = data?["phoneNumber"] as? String ?? "No contact No."
            let dob = data?["DOB"] as? String ?? "No DOB"
            let photoURL = data?["photoURL"] as? String // Retrieve photo URL

              
            
            self?.TF_name.text = name
            self?.TF_email.text = email
            self?.TF_phone.text = contact_no
            self?.dp_dob.text = dob
            
            if let photoURL = photoURL {
                        if let url = URL(string: photoURL) {
                            URLSession.shared.dataTask(with: url) { data, response, error in
                                if let data = data, let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        self?.img_add.image = image
                                    }
                                }
                            }.resume()
                }
            }

        }
    }
}
extension String {
    func isValidEmaill() -> Bool {
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

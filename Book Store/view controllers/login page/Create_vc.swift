//
//  Create_vc.swift
//  book store
//
//  Created by Apple 16 on 05/07/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class Create_vc: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var TF_name: UITextField!
    
    @IBOutlet weak var TF_phonenumber: UITextField!
    
    @IBOutlet weak var TF_Email: UITextField!
    
    @IBOutlet weak var TF_password: UITextField!
    
    
    @IBAction func create_page_back(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Act_button(_ sender: UIButton) {
      //  let storyboard = UIStoryboard(name: "Main", bundle: nil)
       // let vc = storyboard.instantiateViewController(withIdentifier: "Start_vc") as! Start_vc
       // self.navigationController?.pushViewController(vc, animated: true)
        let Email = self.TF_Email.text!
        let password = self.TF_password.text!
        let phonenumber = self.TF_phonenumber.text!
        let name = self.TF_name.text!
        // Check if email is entered and validate its format
        guard  Email.isEmpty == false else {
            showAlert(title: "Error", message: "Please enter your email.")
            return
        }
        // Validate email format using a regular expression
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        guard emailPredicate.evaluate(with: Email) else {
            showAlert(title: "Error", message: "Please enter a valid email address.")
            return
        }
        
        guard password.isEmpty == false else {
            showAlert(title: "Error", message: "Please enter your password.")
            return
        }
        
        // Validate password criteria (e.g., minimum length)
        if password.count < 6 {
            showAlert(title: "Error", message: "Password must be at least 6 characters long.")
            return
        }

        // Fetch the selected gender from UISegmentedControl
        
        // Check if a mobile number is entered
        guard phonenumber.isEmpty == false else {
            showAlert(title: "Error", message: "Please enter a valid phone number.")
            return
        }
        //print("SignupVC successful for username: \(Email)")
        //print("Password: \(password)")
        //print("mobileNumber: \(mobileno)")
        
        
        
        // Validate that the entered number has exactly 10 digits
        let mobileNumberRegex = "^[0-9]{10}$"
        let mobileNumberPredicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        
        guard mobileNumberPredicate.evaluate(with: phonenumber) else {
            showAlert(title: "Error", message: "Please enter a valid 10-digit mobile number.")
            return
            
        }
        signup_firebase(phonenumber: phonenumber)
    }
    
    func signup_firebase(phonenumber: String){
         let Email = self.TF_Email.text!
        let password = self.TF_password.text!
        let phonenumber = self.TF_phonenumber.text!
        let name = self.TF_name.text!
        
        Auth.auth().createUser(withEmail: Email, password: password){
            authResult, error in
            
            if let nsError = error as? NSError{
                if let  errorcode = AuthErrorCode.Code(rawValue: nsError.code){
                    switch errorcode {
                    case .invalidEmail:
                        self.showAlertToast(message: "Invalid Email Format")
                    case .emailAlreadyInUse:
                        self.showAlertToast(message: "Email Already in use")
                    default:
                        print("Error Saving User details:\(nsError.localizedDescription)")
                    }
                    
                }else{
                    print("signup is Successful")
                }
            }
            guard let uid = authResult?.user.uid else {return }
//            UserDefaults.standard.set(uid, forKey: "User_id")
            let db = Firestore.firestore()
            db.collection("user").document(uid).setData([
                "name" : name,
                "Email" : Email,
                "phoneNumber"  : phonenumber,
                "password" : password
            ]) { error in
                if let error = error {
                    print("Error Saving User details:\(error.localizedDescription)")
                }else{
                    print("user Details Saved Successfully!")
                    let storyboard = UIStoryboard(name: "Home", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "navigate_home") as! UINavigationController
                    self.present(vc, animated: true)

                }
             }
            
        }
    }
    
    
    
}
extension String {
//    func isValidEmail() -> Bool {
//        let regex = try! NSRegularExpression(pattern:
//                                                "^[a-zA-Z0-9 .!#$ &'+/=?^_'{|}--]+@[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9])?)$", options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
//    }
}
extension String {
    func  isValidPhoneNumber(_phoneNumber: String) -> Bool {
        let phoneRegex =  "^\\d{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: _phoneNumber)
        
    }
}





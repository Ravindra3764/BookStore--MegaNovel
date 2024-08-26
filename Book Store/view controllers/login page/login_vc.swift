
import UIKit
import FirebaseAuth
import FirebaseFirestore

class login_vc: UIViewController {
    
    @IBOutlet var TF_password: UITextField!
    
    @IBOutlet var TF_email: UITextField!
    
    var isEmailEmpty = true
       var isPasswordEmpty = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
     }
    
    
    @IBAction func login_back_button(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func act_signup(_ sender: UIButton) {
         let email = self.TF_email.text!
        let password = self.TF_password.text!
               if email.isEmpty || password.isEmpty {
                   showAlert(title: "Error",message: "Please enter both email & password.")
                           return
                       }
        
                        showProgressBar()
                         Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                            if let error = error {
                           
                                self.hideProgressBar()
                               print("Error logging in: \(error.localizedDescription)")
                                self.showAlertToast(message: error.localizedDescription)
//                                self.showAlert(title: "Error", message: "Invalid Email or credentials")
                                 return
                           }
                            self.hideProgressBar()
                             
                             guard let uid = authResult?.user.uid else {return }


                           // User successfully logged in
                           print("Login successful!")
                           
                           let storyboard = UIStoryboard(name: "Home", bundle: nil)
                           let vc = storyboard.instantiateViewController(withIdentifier: "navigate_home") as! UINavigationController
                           self.present(vc, animated: true)

                           // Optionally save user email to UserDefaults
                           UserDefaults.standard.setValue(uid, forKey: "User_id")
                           print(UserDefaults.standard.string(forKey: "User_id") ?? "not fetched")
                           
                       }
     }
      
           }
       extension UIViewController {
           
           var result: String? {
                 get {
                     return UserDefaults.standard.string(forKey: "email")
                 }
                 set(newVal) {
                     UserDefaults.standard.setValue(newVal, forKey: "email")
                 }
             }
       }


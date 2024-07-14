//
//  login_vc.swift
//  book store
//
//  Created by Apple 16 on 13/06/24.
//

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
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func act_signup(_ sender: UIButton) {
        let email = self.TF_email.text!
                   let password = self.TF_password.text!
                   
               if email.isEmpty || password.isEmpty {
                   showAlert(title:"Error", message: "Please enter both email & password.")
                           return
                       }
                    showAlert( title:"Error",message: "invalid email and password")
                       Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                           if let error = error {
                              
                              // print("Error logging in: \(error.localizedDescription)")
                             //  self.showAlert(message: "Error logging in. Please check your credentials and try again.")
                               return
                           }

                           // User successfully logged in
                           print("Login successful!")
                           // Example: Navigate to another view controller upon successful login
                           // self.performSegue(withIdentifier: "LoggedInSegue", sender: nil)

                           // Optionally save user email to UserDefaults
                           UserDefaults.standard.setValue(email, forKey: "email")
                           
                       }
                  
                   // let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  //  let vc = storyboard.instantiateViewController(withIdentifier: "Start_vc") as! Start_vc
                   // self.navigationController?.pushViewController(vc, animated: true)
                   }
         
     
         
           }
           
func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    // self.present(alert, animated: true, completion: nil)
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


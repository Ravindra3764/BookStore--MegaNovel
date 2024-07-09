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
    
    @IBOutlet weak var TF_name: UITextField!
    @IBOutlet weak var TF_password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Act_forgot(_ sender: UIButton) {
    }
    
    @IBAction func act_signup(_ sender: UIButton) {
                guard let username = TF_name.text, !username.isEmpty else {
                    showAlert(title: "ERROR", message: "Name is required")
                    return
                }
        
        
                guard let userpassword = TF_password.text, !userpassword.isEmpty else {
                    showAlert(title: "ERROR", message: "Password is required")
                    return
                }
                
                login_firebase(username: username, userpassword: userpassword)
            }
            
            func login_firebase(username: String, userpassword: String) {
                let email = "\(username)@example.com" // Replace example.com with your domain
                
                Auth.auth().signIn(withEmail: email, password: userpassword) { [weak self] authResult, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        self.showAlert(title: "ERROR", message: error.localizedDescription)
                    } else {
                        guard let uid = authResult?.user.uid else { return }
                        
                        let db = Firestore.firestore()
                        db.collection("user").document(uid).setData([
                            "username": username,
                            "password": userpassword
                        ]) { error in
                            if let error = error {
                                print("Error saving user details: \(error.localizedDescription)")
                            } else {
                                print("User details saved successfully!")
                                self.navigateTostart()
                            }
                        }
                    }
                }
            }
            
            func showAlert(title: String, message: String) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            func navigateTostart() {
                if let start_vc = self.storyboard?.instantiateViewController(withIdentifier: "Start_vc") {
                    self.navigationController?.pushViewController(start_vc, animated: true)
                }
            }
        }


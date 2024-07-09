//
//  Reset_vc.swift
//  book store
//
//  Created by Apple 16 on 14/06/24.
//

import UIKit

class Reset_vc: UIViewController {
    @IBOutlet weak var TF_password: UITextField!
    
    @IBOutlet weak var TF_confirmpass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btn_reset(_ sender: UIButton) {
        let password = self.TF_password.text!
        let confirmpass = self.TF_confirmpass.text!
        
        guard password.isEmpty == false else{
            showAlert (title: "Error", message: " please fill password ")
            return
        }
        
        guard confirmpass.isEmpty == false else{
            showAlert (title: "Error", message: " please fill confirmpass ")
            return
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Start_vc") as! Start_vc
        // vc.password = self.TF_password.text!
        //   vc.confirmpass = self.TF_confirmpass.text!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func showAlert(title: String, message : String){
        let missinginformationAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        missinginformationAlert.addAction(cancelAction)
        self.present (missinginformationAlert, animated: true, completion:nil)
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}

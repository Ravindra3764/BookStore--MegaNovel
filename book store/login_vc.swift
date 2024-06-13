//
//  login_vc.swift
//  book store
//
//  Created by Apple 16 on 12/06/24.
//

import UIKit

class login_vc: UIViewController {
    @IBOutlet weak var TF_name: UITextField!
    
    @IBOutlet weak var TF_email: UITextField!
   
    @IBOutlet weak var TF_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btn_signup(_ sender: UIButton) {
    }
    
    @IBAction func act_forgot(_ sender: UIButton) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

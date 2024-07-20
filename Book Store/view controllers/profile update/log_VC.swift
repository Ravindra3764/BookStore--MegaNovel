//
//  log_VC.swift
//  book store
//
//  Created by Apple 6 on 13/06/24.
//

import UIKit

class log_VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
         
        

    
    }

    @IBAction func act_cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
      
    
    }
    
    
    @IBAction func Logout_button(_ sender: UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "User_id")
        if let frontPageVC = storyboard?.instantiateViewController(withIdentifier: "front_vc") as? front_vc {
            
            self.navigationController?.pushViewController(frontPageVC, animated: true)
         }

    }
    

}

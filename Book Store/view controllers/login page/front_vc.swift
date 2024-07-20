//
//  front_vc.swift
//  book store
//
//  Created by Apple 16 on 13/06/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class front_vc: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func act_login(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "login_vc") as! login_vc
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
 
   
    @IBAction func act_create(_ sender: UIButton) {
    
    
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Create_vc") as! Create_vc
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

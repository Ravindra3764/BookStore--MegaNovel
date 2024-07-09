//
//  Survey_vc.swift
//  book store
//
//  Created by Apple 16 on 02/07/24.
//

import UIKit

class Survey_vc: UIViewController {
    @IBOutlet weak var TF_about: UILabel!
    
    
    @IBOutlet weak var selectedGenderLabel: UILabel!
    
    
    @IBOutlet weak var img_8: UIImageView!
    
    @IBOutlet weak var img_7: UIImageView!
    
    @IBOutlet weak var img_6: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btn_male(_ sender: UIButton) {
        updateSelectedGender(gender : "male")
    }
    
    @IBAction func btn_female(_ sender: UIButton) {
        updateSelectedGender(gender : "female")
    }
    
    @IBAction func btn_others(_ sender: UIButton) {
        updateSelectedGender(gender : "others")
    }
    
    func  updateSelectedGender(gender : String){
        selectedGenderLabel.text = " Selected Gender : \(gender)"
        
        //Example of using conditions
        switch gender{
        case"male":
            //Do Something specific for male
            print (" male selected ")
            
        case"female":
            //Do Something specific for female
            print (" female selected ")
            
        case"others":
            //Do Something specific for others
            print (" others selected ")
        default:
            break
            
        }
        
    }
    @IBAction func btn_ready(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Age_vc") as! Age_vc
        self.navigationController?.pushViewController(vc, animated: true)
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


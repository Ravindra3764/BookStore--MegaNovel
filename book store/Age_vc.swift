//
//  Age_vc.swift
//  book store
//
//  Created by Apple 16 on 15/06/24.
//

import UIKit

class Age_vc: UIViewController {
    
    @IBOutlet weak var TF_you: UILabel!
    @IBOutlet weak var TF_what: UILabel!
    
    
    var selectedAge: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the selectedAge value as needed
        if let age = selectedAge {
            print("Selected age group: \(age)")
        }
       
    }
      
    
    
    @IBAction func btn_18(_ sender: UIButton) {
        selectedAge = "18-24"
        updateLabels()
    }
    
    @IBAction func btn_25(_ sender: UIButton) {
        selectedAge = "25-34"
        updateLabels()
    }
    
    @IBAction func btn_35(_ sender: UIButton) {
        selectedAge = "35-44"
        updateLabels()
    }
    
    @IBAction func btn_45(_ sender: UIButton) {
        selectedAge = "45-54"
        updateLabels()
    }
    
    
    @IBAction func btn_55(_ sender: Any) {
        selectedAge = "55+"
        updateLabels()
    }
    
    
    
    
    @IBAction func btn_continue(_ sender: UIButton) {
        guard let selectedAge = selectedAge else {
            // Handle the case where no age is selected
            let alert = UIAlertController(title: "No Age Selected", message: "Please select an age group before continuing.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Navigate to the next view controller
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Survey_vc") as? Survey_vc {
         navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func updateLabels() {
        guard let selectedAge = selectedAge else { return }
        TF_you.text = "You have selected: \(selectedAge)"
        TF_what.text = "Selected age group is: \(selectedAge)"
    }
}

   
      
   
    
    

   
   
  
      
   
      

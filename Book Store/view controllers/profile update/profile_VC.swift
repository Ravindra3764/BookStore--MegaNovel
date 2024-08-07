//
//  ViewController.swift
//  book store
//
//  Created by Apple 6 on 12/06/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class profile_VC: UIViewController{
    var uid: String?

    
    @IBOutlet weak var lbl_name: UILabel!
   
    
    @IBOutlet weak var img_dp: UIImageView!
    
    @IBOutlet weak var tbl_view: UITableView!
    let imgArr = [UIImage(systemName: "pencil.and.outline" ), UIImage(systemName: "a.book.closed")]
    
    
    let titleArr = ["Edit Profile Details","My Order"]
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser {
            uid = currentUser.uid
         } else {
            print("No user is signed in")
        }

                
        let imgwidth = img_dp.frame.size.height
        img_dp.layer.cornerRadius = imgwidth / 2
        img_dp.clipsToBounds = true
        img_dp.layer.masksToBounds = true
        img_dp.contentMode = .scaleAspectFill
        
        img_dp.layer.borderWidth = 2.0
        img_dp.layer.borderColor = UIColor.white.cgColor
        
        
        self.tbl_view.register(UINib(nibName: "acc_TB", bundle: nil), forCellReuseIdentifier: "acc_TB")
        
        db = Firestore.firestore()
        
     }
    
    func fetchUserData(){
        
        let documentID = "User_id"
        
        db.collection("user").document("uid").getDocument { (document, error) in
            
            if let document = document, document.exists {
                let data = document.data()
                let name = data?["name"] as? String ?? "No Name"
                let email = data?["email"] as? String ?? "No email"
                
                self.lbl_name.text = name
            }else{
                print("Document not exist")
            }
            
        }
        
        
     }


    @IBAction func act_log(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "log_VC") as! log_VC
        vc.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(vc, animated: true)
       
        
    }
}
extension profile_VC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tbl_view.dequeueReusableCell(withIdentifier: "acc_TB") as! acc_TB
        
        
        
        print(indexPath)
        cell.img_icon.image = self.imgArr[indexPath.row]
        
        cell.lbl_nm.text = self.titleArr[indexPath.row]
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "edit_VC") as! edit_VC
            self.navigationController?.pushViewController(vc, animated: true)
        
        }
        else if indexPath.row == 1 {
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "order_VC") as! order_VC
            self.navigationController?.pushViewController(vc, animated: true)
        
        }
        
        
    }
    
}

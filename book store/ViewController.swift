//
//  ViewController.swift
//  book store
//
//  Created by Apple 6 on 12/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tbl_view: UITableView!
    let imgArr = [UIImage(systemName: "a.book.closed"), UIImage(systemName:"suit.heart"), UIImage(systemName: "wallet.pass"), UIImage(systemName:"gearshape")]
    
    
    let titleArr = ["My Order","Favourite","Payment","Setting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbl_view.register(UINib(nibName: "acc_TB", bundle: nil), forCellReuseIdentifier: "acc_TB")
        
        // Do any additional setup after loading the view.
    }


}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
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

    
}

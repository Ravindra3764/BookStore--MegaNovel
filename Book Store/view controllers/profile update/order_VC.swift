//
//  order_VC.swift
//  book store
//
//  Created by Apple 6 on 14/06/24.
//

import UIKit

class order_VC: UIViewController {
let orderArr = ["First order","second order"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var table_order: UITableView!
    
    @IBAction func act_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
}
extension order_VC:  UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table_order.dequeueReusableCell(withIdentifier: "Table") as! Table
        
        
        
        print(indexPath)
        
        cell.lbl_bookname.text  = self.orderArr[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}



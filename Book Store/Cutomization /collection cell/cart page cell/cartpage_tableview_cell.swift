//
//  cartpage_tableview_cell.swift
//  book store
//
//  Created by Apple 11 on 14/06/24.
//

import UIKit

class cartpage_tableview_cell: UITableViewCell {
    
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var ShippingstatusLabel: UILabel!
    @IBOutlet weak var productpricelabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    func configure(with item: CartItem) {
        productname.text = item.title
        productpricelabel.text = "$\(item.price)"
       }
    
}

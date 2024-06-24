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
    
    var priceTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        productpricelabel.isUserInteractionEnabled = true
        productpricelabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        priceTapped?()
        
        func awakeFromNib() {
            super.awakeFromNib()
            
            // Customize the labels
            productname.font = UIFont.boldSystemFont(ofSize: 16)
            productname.textColor = UIColor.darkGray
            
            ShippingstatusLabel.font = UIFont.systemFont(ofSize: 14)
            ShippingstatusLabel.textColor = UIColor.gray
            
            productpricelabel.font = UIFont.systemFont(ofSize: 16)
            productpricelabel.textColor = UIColor.blue
            
            // Add rounded corners and shadow to the cell
            contentView.layer.cornerRadius = 10
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowOpacity = 0.1
            contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
            contentView.layer.shadowRadius = 3
            
        }
    }
}

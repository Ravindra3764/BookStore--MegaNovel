//
//  Table.swift
//  book store
//
//  Created by Apple 6 on 10/07/24.
//

import UIKit

class Table: UITableViewCell {

    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_author: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_bookname: UILabel!
    @IBOutlet weak var img_book: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

import UIKit
import Kingfisher

protocol CartPageTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(cell: cartpage_tableview_cell)
}

class cartpage_tableview_cell: UITableViewCell{

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    weak var delegate: CartPageTableViewCellDelegate?

    func configure(with item: CartItem) {
        titleLabel.text = item.title
        authorLabel.text = "Free Shipping" // Assuming free shipping is always displayed
        priceLabel.text = String(format: "$%.2f", item.price)
        if let url = URL(string: item.imageUrl) {
            bookImageView.kf.setImage(with: url)
        }
    }

    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.didTapDeleteButton(cell: self)
        
    }

}

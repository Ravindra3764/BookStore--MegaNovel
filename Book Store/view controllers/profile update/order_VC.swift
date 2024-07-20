import UIKit
import FirebaseFirestore
import FirebaseAuth

class order_VC: UIViewController {
    var orders: [[String: Any]] = []
    @IBOutlet weak var table_order: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.table_order.register(UINib(nibName: "Table", bundle: nil), forCellReuseIdentifier: "Table")
        self.table_order.delegate = self
        self.table_order.dataSource = self
        fetchOrders()
    }

    @IBAction func act_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func fetchOrders() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("user").document(uid).collection("myorders").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error getting orders: \(error)")
            } else {
                self?.orders = querySnapshot?.documents.compactMap { $0.data() } ?? []
                self?.table_order.reloadData()
            }
        }
    }
}

extension order_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table_order.dequeueReusableCell(withIdentifier: "Table") as! Table
        let order = orders[indexPath.row]

        // Configure cell with order data
        if let title = order["title"] as? String {
            cell.lbl_bookname.text = title
        }
        if let author = order["author"] as? String {
            cell.lbl_author.text = author
        }
        if let price = order["price"] as? Double {
            cell.lbl_price.text = String(format: "$%.2f", price)
        }
        if let date = order["orderDate"] as? Timestamp {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            cell.lbl_date.text = dateFormatter.string(from: date.dateValue())
        }
        if let imageUrl = order["imageUrl"] as? String, let url = URL(string: imageUrl) {
             cell.img_book.kf.setImage(with: url) // If using Kingfisher
        }

        return cell
    }
}

import UIKit
import FirebaseFirestore

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    var cartItems: [CartItem] = []
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        fetchCartItems()
    }
    
    func fetchCartItems() {
        db.collection("cart").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.cartItems = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: CartItem.self)
                } ?? []
                self.tableView.reloadData()
                self.updateTotal()
            }
        }
    }
    
    func deleteCartItem(at index: Int) {
        let item = cartItems[index]
        db.collection("cart").document(item.id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                self.cartItems.remove(at: index)
                self.tableView.reloadData()
                self.updateTotal()
            }
        }
    }
    
    func updateTotal() {
        let total = cartItems.reduce(0) { $0 + $1.price }
        totalLabel.text = "Total: $\(total)"
    }

    @IBAction func checkoutTapped(_ sender: UIButton) {
        // Implement checkout functionality
    }

    // MARK: - TableView DataSource and Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
        let item = cartItems[indexPath.row]
        cell.configure(with: item)
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        deleteCartItem(at: sender.tag)
    }
}

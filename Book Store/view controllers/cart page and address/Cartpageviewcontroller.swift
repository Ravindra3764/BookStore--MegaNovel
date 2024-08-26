import UIKit
import FirebaseFirestore
import FirebaseAuth
import Kingfisher

class Cartpageviewcontroller: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!

    @IBOutlet weak var Item_total_label: UILabel!
     var db: Firestore!
    var cartItems: [CartItem] = []
    var totalAmount: Double = 0.0
    var uid: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser {
            uid = currentUser.uid
        } else {
            print("No user is signed in")
        }

        fetchCartItems()

        tableView.dataSource = self
        tableView.delegate = self

        // Register the custom cell
        self.tableView.register(UINib(nibName: "cartpage_tableview_cell", bundle: nil), forCellReuseIdentifier: "cartpage_tableview_cell")

        // Customize the table view
        self.tableView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor.lightGray
        self.tableView.tableFooterView = UIView() // To remove extra separators
    }

    func fetchCartItems() {
        guard let uid = uid else {
            print("User ID is nil")
            return
        }

        if let savedCartItems = UserDefaults.standard.array(forKey: "cartItems") as? [[String: Any]] {
            self.cartItems = savedCartItems.map { data in
                return CartItem(
                    id: data["id"] as? String ?? "",
                    title: data["title"] as? String ?? "",
                    author: data["author"] as? String ?? "",
                    price: data["price"] as? Double ?? 0.0,
                    description: data["description"] as? String ?? "",
                    imageUrl: data["imageUrl"] as? String ?? ""
                )
            }
            self.tableView.reloadData()
            self.updateTotal()
        }

        db.collection("user").document(uid).collection("cart").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.cartItems.removeAll()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if let title = data["title"] as? String,
                       let author = data["author"] as? String,
                       let price = data["price"] as? Double,
                       let description = data["description"] as? String,
                       let imageUrl = data["imageUrl"] as? String {
                        let item = CartItem(id: document.documentID, title: title, author: author, price: price, description: description, imageUrl: imageUrl)
                        self.cartItems.append(item)
                    }
                }
                self.tableView.reloadData()
                self.updateTotal()
                self.saveCartItemsLocally(cartItems: self.cartItems)
            }
        }
    }

    func deleteCartItem(at index: Int) {
        guard let uid = uid else {
            print("User ID is nil")
            return
        }

        let item = cartItems[index]
        db.collection("user").document(uid).collection("cart").document(item.id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.cartItems.remove(at: index)
                self.tableView.reloadData()
                self.updateTotal()
                self.saveCartItemsLocally(cartItems: self.cartItems)
            }
        }
    }

    func updateTotal() {
        totalAmount = cartItems.reduce(0) { $0 + $1.price }
        totalAmountLabel.text = String(format: "$%.2f", totalAmount)
        Item_total_label.text = String(format: "$%.2f", totalAmount)
    }

    @IBAction func checkoutTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let addAddressVC = storyboard.instantiateViewController(withIdentifier: "AddAddressViewController") as? AddAddressViewController {
            addAddressVC.cartItems = cartItems
            addAddressVC.delegate = self
            present(addAddressVC, animated: true, completion: nil)
        }
    }

    @IBAction func CartPageVC_back_Btn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    func saveCartItemsLocally(cartItems: [CartItem]) {
        let cartItemsData = cartItems.map { item in
            return [
                "id": item.id,
                "title": item.title,
                "author": item.author,
                "price": item.price,
                "description": item.description,
                "imageUrl": item.imageUrl
            ] as [String: Any]
        }
        UserDefaults.standard.set(cartItemsData, forKey: "cartItems")
    }
}

extension Cartpageviewcontroller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartpage_tableview_cell", for: indexPath) as! cartpage_tableview_cell

        let item = cartItems[indexPath.row]
        cell.configure(with: item)
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust as needed
    }

    @objc func deleteButtonTapped(_ sender: UIButton) {
        deleteCartItem(at: sender.tag)
    }
}

extension Cartpageviewcontroller: AddAddressViewControllerDelegate {
    func clearCart() {
        cartItems.removeAll()
        tableView.reloadData()
        updateTotal()
        saveCartItemsLocally(cartItems: [])
    }
}

extension Cartpageviewcontroller: CartPageTableViewCellDelegate {
    func didTapDeleteButton(cell: cartpage_tableview_cell) {
        if let indexPath = tableView.indexPath(for: cell) {
            deleteCartItem(at: indexPath.row)
        }
    }
}
 

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Kingfisher

class book_description_VC: UIViewController {
    var bookDic: [BookData] = []
    var book: BookData?
    
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet weak var Book_description_book_Image: UIImageView!
    @IBOutlet weak var Book_description_book_title: UILabel!
    @IBOutlet weak var Book_description_book_author_name: UILabel!
    @IBOutlet weak var Book_description_book_description: UILabel!
    @IBOutlet weak var Book_description_book_price: UILabel!
    
    let db = Firestore.firestore()
    var uid: String?

    override func viewDidLoad() {
        super.viewDidLoad()
//        Book_description_book_description.lineBreakMode = .byTruncatingTail
//        Book_description_book_description.numberOfLines = 4
        
        if let book = book {
            Book_description_book_title.text = book.bookName
            Book_description_book_author_name.text = book.authorName
            Book_description_book_description.text = book.description
            Book_description_book_price.text = "$\(book.price)"
            
            if let url = URL(string: book.bookImage) {
                Book_description_book_Image.kf.setImage(with: url)
            }
        }
        
        if let contentURL = book?.bookContent, !contentURL.isEmpty {
            readButton.isHidden = false
        } else {
            readButton.isHidden = true
        }
        
        if let currentUser = Auth.auth().currentUser {
            uid = currentUser.uid
        } else {
            print("No user is signed in")
        }
    }
    
    @IBAction func Book_description_Read_btn(_ sender: UIButton) {
        showProgressBar()
        let vc = self.storyboard?.instantiateViewController(identifier: "PDF_Reader_VC") as! PDF_Reader_VC
        vc.book = book
        self.present(vc, animated: true)
        hideProgressBar()
    }
    
    @IBAction func Book_Description_Buy_btn(_ sender: UIButton) {
        if let book = book {
            addToCart(book: book)
        }
        showAlert(message: "Book Added in cart")
    }
    
    func addToCart(book: BookData) {
        guard let uid = uid else {
            print("User ID is nil")
            return
        }
        
        let cartItem = [
            "title": book.bookName,
            "author": book.authorName,
            "price": book.price,
            "description": book.description,
            "imageUrl": book.bookImage
        ] as [String: Any]
        
        db.collection("user").document(uid).collection("cart").addDocument(data: cartItem) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added in cart collection: \(book.bookId)")
                self.saveCartItemsLocally(uid: uid)
            }
        }
    }
    
    func saveCartItemsLocally(uid: String) {
        db.collection("user").document(uid).collection("cart").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var cartItems: [[String: Any]] = []
                for document in querySnapshot!.documents {
                    cartItems.append(document.data())
                }
                UserDefaults.standard.set(cartItems, forKey: "cartItems")
            }
        }
    }
    
    func showAlert(message: String){
        let alertcontroller = UIAlertController(title: "Congratulation", message: message, preferredStyle: .alert)
        present(alertcontroller, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            alertcontroller.dismiss(animated: true, completion: nil)
        }
    }
}

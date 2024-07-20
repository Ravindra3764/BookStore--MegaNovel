//import Foundation
//import FirebaseFirestore
//
//
//class CartService {
//    static let shared = CartService()
//    private let db = Firestore.firestore()
//    private let userID = "user123" // This should be dynamically set to the current user's ID
//
//    func addBook(_ book: BookData) {
//        let cartRef = db.collection("carts").document(userID)
//        let bookRef = cartRef.collection("items").document(book.bookId)
//        
//        bookRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                if let data = document.data(), let quantity = data["quantity"] as? Int {
//                    bookRef.updateData(["quantity": quantity + 1])
//                }
//            } else {
//                bookRef.setData([
//                    "bookID": book.bookId,
//                    "bookName": book.bookName,
//                    "authorName": book.authorName,
//                    "description": book.description,
//                    "price": book.price,
//                    "bookImage": book.bookImage,
//                    "quantity": 1
//                ])
//            }
//        }
//    }
//    
//    func getCartItems(completion: @escaping ([CartItem]) -> Void) {
//        let cartRef = db.collection("carts").document(userID).collection("items")
//        
//        cartRef.getDocuments { (querySnapshot, error) in
//            var items: [CartItem] = []
//            if let querySnapshot = querySnapshot {
//                for document in querySnapshot.documents {
//                    let data = document.data()
//                    if let bookID = data["bookID"] as? String,
//                       let bookName = data["bookName"] as? String,
//                       let authorName = data["authorName"] as? String,
//                       let description = data["description"] as? String,
//                       let price = data["price"] as? Double,
//                       let bookImage = data["bookImage"] as? String,
//                       let quantity = data["quantity"] as? Int {
//                        let book = BookData(bookID: bookID, bookName: bookName, authorName: authorName, description: description, price: price, bookImage: bookImage)
//                        let cartItem = CartItem(book: book, quantity: quantity)
//                        items.append(cartItem)
//                    }
//                }
//            }
//            completion(items)
//        }
//    }
//    
//    func totalPrice(completion: @escaping (Double) -> Void) {
//        getCartItems { items in
//            let total = items.reduce(0) { $0 + ($1.book.price * Double($1.quantity)) }
//            completion(total)
//        }
//    }
//}
//

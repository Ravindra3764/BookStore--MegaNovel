import Foundation
import FirebaseFirestore

class DataManager {
    static let shared = DataManager()

    private init() {}

    func fetchBooks(completion: @escaping ([BookData]?, Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("Books").getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let documents = snapshot?.documents else {
                completion(nil, nil)
                return
            }

            var books: [BookData] = []
            for document in documents {
                if let book = self.mapDocumentToBookData(document) {
                    books.append(book)
                }
            }

            completion(books, nil)
        }
    }

    private func mapDocumentToBookData(_ document: DocumentSnapshot) -> BookData? {
        let data = document.data() ?? [:]

        let authorName = data["Author_Name"] as? String ?? ""
        let bookContent = data["Book_Content"] as? String ?? ""
        let bookId = data["Book_Id"] as? String ?? ""
        let bookImage = data["Book_Image"] as? String ?? ""
        let bookName = data["Book_Name"] as? String ?? ""
        let description = data["Description"] as? String ?? ""
        let price = data["Price"] as? Double ?? 0.0

        return BookData(
            bookId: bookId,
            bookName: bookName,
            authorName: authorName,
            price: price,
            description: description,
            bookImage: bookImage,
            bookContent: bookContent
        )
    }
}

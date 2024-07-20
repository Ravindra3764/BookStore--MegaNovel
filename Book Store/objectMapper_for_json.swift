import Foundation
import ObjectMapper


class Books: Mappable {
   var books : [BookData]?
   
   required init?(map: ObjectMapper.Map) {
   }
   
   func mapping(map: ObjectMapper.Map) {
       books <- map["books"]
   }
}

struct BookData: Mappable {
   var bookId: String = ""
   var bookName: String = ""
   var authorName: String = ""
   var price: Double = 0.0
   var description: String = ""
   var bookImage: String = ""
    var bookContent: String = ""

   init?(map: Map) {}
    
    init(bookId: String, bookName: String, authorName: String, price: Double, description: String, bookImage: String, bookContent: String) {
            self.bookId = bookId
            self.bookName = bookName
            self.authorName = authorName
            self.price = price
            self.description = description
            self.bookImage = bookImage
            self.bookContent = bookContent
        }

   mutating func mapping(map: Map) {
       bookId <- map["Book_Id"]
       bookName <- map["Book_Name"]
       authorName <- map["Author_Name"]
       price <- map["Price"]
       description <- map["Description"]
       bookImage <- map["Book_Image"]/*, URLTransform())*/
       bookContent <- map["Book_Content"]
   }

}
class CartItem: Codable {
    var id: String
    var title: String
    var author: String
    var price: Double
    var description: String
    var imageUrl: String

    init(id: String, title: String, author: String, price: Double, description: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.author = author
        self.price = price
        self.description = description
        self.imageUrl = imageUrl
    }
}
 

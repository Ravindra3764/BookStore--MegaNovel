////
////  Model.swift
////  Book Store
////
////  Created by Ravindra Sirvi on 27/06/24.
//
//import UIKit
//import Foundation
//import ObjeccMapper
//
//class book: Mappable{
//   
//    var name: String?
//    var author: String?
//    var prize: String?
//    
//    
//    required init?(map: Map){}
//    
//    func mapping(map: Map) {
//        name    <- map["rahul"]
//        author  <- map["author"]
//        prize   <- map["prize"]
//    }
//
//}
//// this code will be  implemented later
////let jSondisc: [String: Any] = ["name" : "miraj" , "author" : "Ajay Devgan" , "prize" : "20"]
////    
////    let Book = book(map: jSondisc)
////print(Book?.author)
//
//
//
///*  json file which type is an array and it also contains an array
// 
// {
//   "CountryList": [
//     {
//       "name": "Ascension Island",
//       "code": "AC",
//       "emoji": "🇦🇨",
//       "unicode": "U+1F1E6 U+1F1E8",
//       "image": [
//         {
//           "Image_Id": 1,
//           "Image_Url": "https://cdn.jsdelivr.net/npm/country-flag-emoji-json@2.0.0/dist/images/AC.svg"
//         }
//       ]
//     }
//   ]
// }
// 
// */
//
//class book2: Mappable{
//    
//    
//    var name: String?
//    var code: String?
//    var emoji: String?
//    var unicode: String?
//    var image: [book4]?
// 
//    required init?(map: ObjectMapper.Map) {    }
//    
//    func mapping(map: ObjectMapper.Map) {
//        name <- map["name"]
//        code <- map["code"]
//        emoji <- map["emoji"]
//        unicode <- map["unicode"]
//        image  <- map["book4"]
// 
//    }
//}
//
//class book4: Mappable{
//    
//    var image_id: String?
//    var image_url: String?
//    
//    required init?(map: ObjectMapper.Map) {
//         
//    }
//    
//    func mapping(map: ObjectMapper.Map) {
//        
//        image_id <- map["image_id"]
//        image_url <- map["image_url"]
//    }
//}
//
//
//class book3: Mappable{
//    
//    
//    var country: [book2]?
//
//    required init?(map: ObjectMapper.Map) {
//        
//    }
//    
//    func mapping(map: ObjectMapper.Map) {
//        
//        country <- map["country"]
//    }
// }
//
//
// 
// 
//
// 

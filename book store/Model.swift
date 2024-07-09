//
//  Model.swift
//  book store
//
//  Created by Apple 11 on 27/06/24.
//
import UIKit
import Foundation
import ObjectMapper

class model: Mappable{
    
    var name: String?
    var author: String?
    var prize: String?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        name     <- map["name"]
        author   <- map["author"]
        prize    <- map["prize"]
    }
    

}

      

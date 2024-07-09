//
//  book description_VC.swift
//  Book Store
//
//  Created by Ravindra Sirvi on 24/06/24.
//

import UIKit



class book_description_VC: UIViewController {
    
    var book: BookData?

    @IBOutlet weak var Book_description_book_Image: UIImageView!
    
    @IBOutlet weak var Book_description_book_title: UILabel!
    
    @IBOutlet weak var Book_description_book_author_name: UILabel!
    
    @IBOutlet weak var Book_description_book_description: UILabel!
    
    @IBOutlet weak var Book_description_book_price: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Book_description_book_description.lineBreakMode = .byTruncatingTail
        Book_description_book_description.numberOfLines = 4
        
        
        if let book = book{
                        
            Book_description_book_title.text = book.bookName
            Book_description_book_author_name.text = book.authorName
            Book_description_book_description.text = book.description
            Book_description_book_price.text =  "$\(book.price)"
            
            if let url = URL(string: book.bookImage){
                Book_description_book_Image.kf.setImage(with: url)
            }
            
        }
    }
    
    
    @IBAction func Book_description_Read_btn(_ sender: UIButton) {
    }
    
    
    @IBAction func Book_Description_Buy_btn(_ sender: UIButton) {
    }
}

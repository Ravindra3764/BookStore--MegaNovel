//
//  BookStorePage_vc.swift
//  Book Store
//
//  Created by Apple 14 on 13/06/24.
//

import UIKit
import Kingfisher

class BookStorePage_vc: UIViewController {

    @IBOutlet weak var BookStore_featured_coll_view: UICollectionView!
    
    @IBOutlet weak var bookStore_non_fictional_coll_view: UICollectionView!
    @IBOutlet weak var bookStore_fictional_coll_view: UICollectionView!
    
 
    var bookDic : [BookData] = []

    let booktitleArr = ["Biography" ,"Short Story" ,"Histry" ,"Philosophy" , "poetry"]
    
    let bookimageArr = [UIImage(named: "book image 1") , UIImage(named: "book image2") , UIImage(named: "book image 3"),UIImage(named: "book image 4") ,UIImage(named: "book image 5")]
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.bookDic = DataManager.shared.getBooks()

        self.BookStore_featured_coll_view.register(UINib(nibName: "BookStore_featured_coll_cell", bundle: nil), forCellWithReuseIdentifier: "BookStore_featured_coll_cell")
 
        self.bookStore_fictional_coll_view.register(UINib(nibName: "BookType_coll_cell", bundle: nil), forCellWithReuseIdentifier: "BookType_coll_cell")
 
        self.bookStore_non_fictional_coll_view.register(UINib(nibName: "BookType_coll_cell", bundle: nil), forCellWithReuseIdentifier: "BookType_coll_cell")
        
        fetchBooks()
 
//        self.bookStore_nonFictional_coll_View.register(UINib(nibName: "BookType_coll_cell", bundle: nil), forCellWithReuseIdentifier: "BookType_coll_cell")
    }
    
    private func shuffleAndReloadData() {
        self.bookDic.shuffle()
        self.bookStore_fictional_coll_view.reloadData()
     }

    
    func fetchBooks(){
        
        DataManager.shared.fetchBooks { books, error in
            if let error = error{
                print("Error in fetching data:", error.localizedDescription)
                self.showAlertToast(message: error.localizedDescription)

                return
            }
            self.bookDic = books ?? []
            self.shuffleAndReloadData()
            self.BookStore_featured_coll_view.reloadData()
            self.bookStore_fictional_coll_view.reloadData()
            self.bookStore_non_fictional_coll_view.reloadData()
        }
    }
    
 
}

extension BookStorePage_vc : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            if collectionView == self.BookStore_featured_coll_view {
                return bookimageArr.count
            }
        else if collectionView == self.bookStore_fictional_coll_view  {
            return bookDic.count
        }

        
        else if collectionView == bookStore_non_fictional_coll_view{
            return bookDic.count
        }
        else{
            return bookDic.count
        }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.BookStore_featured_coll_view {
        let cell = self.BookStore_featured_coll_view.dequeueReusableCell(withReuseIdentifier: "BookStore_featured_coll_cell", for: indexPath) as! BookStore_featured_coll_cell

        
            cell.FeatureBook_title.text = self.booktitleArr[indexPath.row]
        cell.FeatureBook_image.image =  self.bookimageArr[indexPath.row]
        return cell
        }else if collectionView == self.bookStore_fictional_coll_view{
            let cell = self.bookStore_fictional_coll_view.dequeueReusableCell(withReuseIdentifier: "BookType_coll_cell", for: indexPath) as! BookType_coll_cell
            
            let list = bookDic[indexPath.row]
            
            if let url = URL(string: list.bookImage){
                
                cell.BookTypeImage.kf.setImage(with: url)
              }
            else{
                
                cell.BookTypeImage.image = UIImage(named: "book image 2")
     
            }
            
            return cell
         }
        else {
            let cell = self.bookStore_non_fictional_coll_view.dequeueReusableCell(withReuseIdentifier: "BookType_coll_cell", for: indexPath) as! BookType_coll_cell
            let list = bookDic[indexPath.row]
            
            if let url = URL(string: list.bookImage){
                
                cell.BookTypeImage.kf.setImage(with: url)
             }
            else{
                
                cell.BookTypeImage.image = UIImage(named: "book image 2")
     
            }
            
            return cell

        }
    
    }
    
 
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            

            if collectionView == BookStore_featured_coll_view{
                // Get the selected cell
               
                let cell = collectionView.cellForItem(at: indexPath)
                
                // Perform the segue or present the new view controller
                let bookDescriptionVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AllBook_listing_Page_VC") as! AllBook_listing_Page_VC
 
                
                self.present(bookDescriptionVC, animated: true, completion: nil)
            }
            else{
                // Get the selected cell
                let selectedBook = bookDic[indexPath.row]

                let cell = collectionView.cellForItem(at: indexPath)
                
                // Perform the segue or present the new view controller
                let bookDescriptionVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "book_description_VC") as! book_description_VC
                
             
                bookDescriptionVC.book = selectedBook
                
               
                // Present the book description view controller
                self.present(bookDescriptionVC, animated: true, completion: nil)
            }
        }
    
}






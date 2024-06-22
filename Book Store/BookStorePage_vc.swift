//
//  BookStorePage_vc.swift
//  Book Store
//
//  Created by Apple 14 on 13/06/24.
//

import UIKit

class BookStorePage_vc: UIViewController {

    @IBOutlet weak var BookStore_featured_coll_view: UICollectionView!
    
    @IBOutlet weak var bookStore_kidsyoung_coll_view: UICollectionView!
    @IBOutlet weak var BookStore_booktype_coll_view: UICollectionView!
    
    let booktitleArr = ["Biography" ,"Short Story" ,"Histry" ,"Philosophy" , "poetry"]
    
    let bookimageArr = [UIImage(named: "book image 1") , UIImage(named: "book image 1") , UIImage(named: "book image 1"),UIImage(named: "book image 1") ,UIImage(named: "book image 1")]
    
    let book_type_imageArr = [UIImage(named: "book image 2") , UIImage(named: "book image 2") , UIImage(named: "book image 2") , UIImage(named: "book image 2")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.BookStore_featured_coll_view.register(UINib(nibName: "BookStore_featured_coll_cell", bundle: nil), forCellWithReuseIdentifier: "BookStore_featured_coll_cell")
        
        self.BookStore_booktype_coll_view.register(UINib(nibName: "BookType_coll_cell", bundle: nil), forCellWithReuseIdentifier: "BookType_coll_cell")
        
        self.bookStore_kidsyoung_coll_view.register(UINib(nibName: "BookType_coll_cell", bundle: nil), forCellWithReuseIdentifier: "BookType_coll_cell")
    }
    
 
}

extension BookStorePage_vc : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            if collectionView == self.BookStore_featured_coll_view {
            return self.booktitleArr.count
            }
        else if collectionView == self.BookStore_booktype_coll_view  {
                return self.book_type_imageArr.count        }
        else{
            return self.book_type_imageArr.count
        }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.BookStore_featured_coll_view {
        let cell = self.BookStore_featured_coll_view.dequeueReusableCell(withReuseIdentifier: "BookStore_featured_coll_cell", for: indexPath) as! BookStore_featured_coll_cell

        
        cell.FeatureBook_title.text = self.booktitleArr[indexPath.row]
        cell.FeatureBook_image.image =  self.bookimageArr[indexPath.row]
        return cell
        }else if collectionView == self.BookStore_booktype_coll_view{
            let cell = self.BookStore_booktype_coll_view.dequeueReusableCell(withReuseIdentifier: "BookType_coll_cell", for: indexPath) as! BookType_coll_cell
            
            cell.BookTypeImage.image = self.book_type_imageArr[indexPath.row]
            
            return cell
        }
        else{
           print("any")
            let cell = self.bookStore_kidsyoung_coll_view.dequeueReusableCell(withReuseIdentifier: "BookType_coll_cell", for: indexPath) as! BookType_coll_cell
            cell.BookTypeImage.image = self.book_type_imageArr[indexPath.row]
            return cell

        }
            
            
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = self.BookStore_featured_coll_view.frame.width
//        let cellWidth = (width / 2) - 15
//        return CGSize(width: cellWidth, height: 250)
//    }
    
    
}






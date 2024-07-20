//
//  HomePage_VC.swift
//  Book Store
//
//  Created by Apple 14 on 12/06/24.
//

import UIKit
import Kingfisher
import FirebaseFirestore
 
class HomePage_VC: UIViewController {
    
    @IBOutlet weak var Homescrn_FictionandLit_img: UIImageView!
    
    @IBOutlet weak var HomeScrn_NonFictional_img: UIImageView!
    @IBOutlet weak var Homescreen_scrlView_allTimeBestSeller: UICollectionView!
    
    var bookDic : [BookData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Homescreen_scrlView_allTimeBestSeller.register(UINib(nibName:"HomeScreen_collectionView_cell", bundle: nil), forCellWithReuseIdentifier: "HomeScreen_collectionView_cell")
            fetchBooks()
//        self.bookDic = DataManager.shared.getBooks()
        self.Homescreen_scrlView_allTimeBestSeller.reloadData()
        
        
//        self.uploadDataToFirebase()
//        
        
        // here "UITapGestureRecognizer" method is used for make images clickcable
        
        let fictionTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fictionImageTapped))
        Homescrn_FictionandLit_img.isUserInteractionEnabled = true
        Homescrn_FictionandLit_img.addGestureRecognizer(fictionTapGestureRecognizer)
        
        let nonFictionTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nonFictionImageTapped))
        HomeScrn_NonFictional_img.isUserInteractionEnabled = true
        HomeScrn_NonFictional_img.addGestureRecognizer(nonFictionTapGestureRecognizer)
    }
    
    func fetchBooks(){
        
        DataManager.shared.fetchBooks { books, error in
            if let error = error{
                print("error in fetching data:", error.localizedDescription)
                return
            }
            self.bookDic = books ?? []
            self.Homescreen_scrlView_allTimeBestSeller.reloadData()
        }
    }
    
//    --> this function is used for setting json data into firebase using for loop and called it into "viewdidload()"
    
//    func uploadDataToFirebase() {
//        let db = Firestore.firestore()
//        for item in bookDic{
//            db.collection("Books").document(item.bookId).setData([
//                "Author_Name": "",
//                "Book_Content": "",
//                "Book_Id": "",
//                "Book_Image": "",
//                "Book_Name": "",
//                "Description": "",
//                "Price": ""
//                
//            ])
//        }
//        
//    }
    
    
    @IBAction func HomePage_Cart_btn(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Cartpageviewcontroller") as! Cartpageviewcontroller
        self.present(vc, animated: true)
    }
}
extension HomePage_VC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookDic.count
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = self.Homescreen_scrlView_allTimeBestSeller.dequeueReusableCell(withReuseIdentifier: "HomeScreen_collectionView_cell", for: indexPath) as! HomeScreen_collectionView_cell
        
        let list = bookDic[indexPath.row]
        
        if let url = URL(string: list.bookImage){
            
            cell.BookImage_cell.kf.setImage(with: url)
         }
        else{
            
            cell.BookImage_cell.image = UIImage(named: "book image 2")
 
        }
        
        return cell
     }
  
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                // Get the selected cell
            let selectedBook = bookDic[indexPath.row]
                // Perform the segue or present the new view controller
                let bookDescriptionVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "book_description_VC") as! book_description_VC
                    bookDescriptionVC.book = selectedBook

                // Pass any necessary data to the book description view controller
    //            bookDescriptionVC.bookTitle = self.booktitleArr[indexPath.row]
    //            bookDescriptionVC.bookImage = self.bookimageArr[indexPath.row]

                // Present the book description view controller
                self.present(bookDescriptionVC, animated: true, completion: nil)
            }
    
   //both objc function is for make image clickable and for navigation to target viewcontroller
    
    @objc func fictionImageTapped() {
        // Navigate to book_description_VC on tap
        let bookDescriptionVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AllBook_listing_Page_VC") as! AllBook_listing_Page_VC
        self.present(bookDescriptionVC, animated: true, completion: nil)
    }

    @objc func nonFictionImageTapped() {
        // Navigate to book_description_VC on tap
        
        
         let bookDescriptionVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AllBook_listing_Page_VC") as! AllBook_listing_Page_VC
        self.present(bookDescriptionVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.Homescreen_scrlView_allTimeBestSeller.frame.width
        let cellwidth = (width / 2)
        return CGSize(width: cellwidth, height: 250)
    }
    
 
 
}


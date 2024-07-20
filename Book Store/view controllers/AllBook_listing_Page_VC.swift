//
//  AllBook_listing_Page_VC.swift
//  Book Store
//
//  Created by Ravindra Sirvi on 25/06/24.
//

import UIKit

class AllBook_listing_Page_VC: UIViewController {

    @IBOutlet weak var Book_list_Page_scrlView: UICollectionView!
    
    var bookDic : [BookData] = []
    
         override func viewDidLoad() {
        super.viewDidLoad()

        self.Book_list_Page_scrlView.register(UINib(nibName: "AllBook_listing_VC", bundle: nil), forCellWithReuseIdentifier: "AllBook_listing_VC")
        
             fetchBooks()
         }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.shuffleAndReloadData()
        }
        
        private func shuffleAndReloadData() {
            self.bookDic.shuffle()
            self.Book_list_Page_scrlView.reloadData()
        }
    private func fetchBooks() {
    DataManager.shared.fetchBooks { [weak self] (books, error) in
        guard let self = self else { return }

        if let error = error {
            print("Error fetching books: \(error)")
            return
        }

        self.bookDic = books ?? []
        self.shuffleAndReloadData()
    }
}
}



extension AllBook_listing_Page_VC : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookDic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let cell = self.Book_list_Page_scrlView.dequeueReusableCell(withReuseIdentifier: "AllBook_listing_VC", for: indexPath) as! AllBook_listing_VC
        
        let list = bookDic[indexPath.row]
        if let url = URL(string: list.bookImage){
            cell.Book_Listing_Page_Img.kf.setImage(with: url)
        }
        else{
            cell.Book_Listing_Page_Img.image = UIImage(named: "book image 2")
        }
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellwidth = (width - 30) / 2
        return CGSize(width: cellwidth, height: 250)
    }
    
    //function for making collection view cell clickable : reference from HomePage_VC
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedBook = bookDic[indexPath.row]
 
        let pdfReaderVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "book_description_VC") as! book_description_VC
        pdfReaderVC.book = selectedBook
        
        
        self.present(pdfReaderVC, animated:  true, completion: nil)
    }
    
    
}



//
//  HomePage_VC.swift
//  Book Store
//
//  Created by Apple 14 on 12/06/24.
//

import UIKit

class HomePage_VC: UIViewController {

    @IBOutlet weak var HomeScreen_ScrlView: UICollectionView!
    
    
    let imageArr = [UIImage(named: "Book section 1") , UIImage(named: "Book section 1") , UIImage(named: "Book section 1")]
    let bookNameArr = ["hindi", "math", "english"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.HomeScreen_ScrlView.register(UINib(nibName:"HomeScreen_collectionView_cell", bundle: nil), forCellWithReuseIdentifier: "HomeScreen_collectionView_cell")
    }
    

    

}

extension HomePage_VC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.HomeScreen_ScrlView.dequeueReusableCell(withReuseIdentifier: "HomeScreen_collectionView_cell", for: indexPath) as! HomeScreen_collectionView_cell
        cell.BookImage_cell.image = self.imageArr[indexPath.row]
        cell.BookName_cell.text = self.bookNameArr [indexPath.row]
        
        
        return cell
        
        
    }
    
    
}


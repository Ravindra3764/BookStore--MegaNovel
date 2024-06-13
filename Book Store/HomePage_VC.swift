//
//  HomePage_VC.swift
//  Book Store
//
//  Created by Apple 14 on 12/06/24.
//

import UIKit

class HomePage_VC: UIViewController {

    @IBOutlet weak var HomeScreen_ScrlView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}

extension HomePage_VC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
    }
    
    
}


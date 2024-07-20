//
//  PDF_Reader_VC.swift
//  Book Store
//
//  Created by Ravindra Sirvi on 09/07/24.
//

import UIKit
import WebKit

class PDF_Reader_VC: UIViewController {
    var book: BookData?

    @IBOutlet weak var PDFReader_content_loader: WKWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        showProgressBar()
        if let book = book, let url = URL(string: book.bookContent) {
                    print("content link:",url)
                    let urlRequest = URLRequest(url: url)
                    PDFReader_content_loader.load(urlRequest)
                }

            hideProgressBar()
        
     }
    
   
    @IBAction func Pdf_reader_cancel_btn(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
}

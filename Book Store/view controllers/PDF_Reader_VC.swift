//
//  PDF_Reader_VC.swift
//  Book Store
//
//  Created by Ravindra Sirvi on 09/07/24.
//

import UIKit
import WebKit

class PDF_Reader_VC: UIViewController, WKNavigationDelegate {
    var book: BookData?

    @IBOutlet weak var PDFReader_content_loader: WKWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        PDFReader_content_loader.navigationDelegate = self

         if let book = book, let url = URL(string: book.bookContent) {
             self.showProgressBar()
                    print("content link:",url)
                    let urlRequest = URLRequest(url: url)
                     PDFReader_content_loader.load(urlRequest)
                 }

     }
    
   
    @IBAction func Pdf_reader_cancel_btn(_ sender: UIButton) {
         self.dismiss(animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.hideProgressBar()
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.hideProgressBar()
            self.showAlertToast(message: error.localizedDescription)        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            self.hideProgressBar()
            print("Failed to start loading content: \(error.localizedDescription)")
        }

}

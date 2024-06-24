import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    let productImageArr: [UIImage] = [
            UIImage(named: "image1")!,
            UIImage(named: "image2")!,
            UIImage(named: "image3")!,
        ]
        
        let productNameArr = ["Atonement", "The Shipping News", "Bless me Ultima"]
        let shippingStatusArr = ["Free Shipping", "Free Shipping", "Free Shipping"]
        let productPriceArr = ["$220", "$380", "$450"]
        
        var totalAmount: Double = 0.0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Register the custom cell
            self.tableView.register(UINib(nibName: "cartpage_tableview_cell", bundle: nil), forCellReuseIdentifier: "cartpage_tableview_cell")
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            // Customize the table view
            self.tableView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
            self.tableView.separatorStyle = .singleLine
            self.tableView.separatorColor = UIColor.lightGray
            self.tableView.tableFooterView = UIView() // To remove extra separators
        }
    }

    extension ViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.productImageArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cartpage_tableview_cell", for: indexPath) as! cartpage_tableview_cell
            
            cell.productimage.image = self.productImageArr[indexPath.row]
            cell.productname.text = self.productNameArr[indexPath.row]
            cell.ShippingstatusLabel.text = self.shippingStatusArr[indexPath.row]
            cell.productpricelabel.text = self.productPriceArr[indexPath.row]
            
            cell.priceTapped = { [weak self] in
                       guard let self = self else { return }
                       let priceText = self.productPriceArr[indexPath.row].replacingOccurrences(of: "$", with: "")
                       if let price = Double(priceText) {
                           self.totalAmount += price
                           self.totalAmountLabel.text = String(format: "$%.2f", self.totalAmount)
                       }
                   }
                   
                   return cell
               }
               
               func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                   return 100 // Adjust as needed
               }
           }


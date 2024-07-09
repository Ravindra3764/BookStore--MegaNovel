import UIKit

class Start_vc: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func act_btn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Survey_vc") as! Survey_vc
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}

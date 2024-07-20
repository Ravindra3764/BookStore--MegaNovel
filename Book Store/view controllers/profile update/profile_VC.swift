import UIKit
import FirebaseFirestore
import FirebaseAuth
import Kingfisher

class profile_VC: UIViewController {
    var uid: String?

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_dp: UIImageView!
    @IBOutlet weak var tbl_view: UITableView!
 
    let imgArr = [UIImage(systemName: "pencil.and.outline"), UIImage(systemName: "a.book.closed")]
    let titleArr = ["Edit Profile Details", "My Order"]
    
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = Auth.auth().currentUser {
            uid = currentUser.uid
        } else {
            print("No user is signed in")
            return
        }
        
        db = Firestore.firestore()
        
        fetchUserData()
         setupImageView()
        setupTableView()
        loadProfileImage()
    }

    private func setupImageView() {
        let imgwidth = img_dp.frame.size.height
        img_dp.layer.cornerRadius = imgwidth / 2
        img_dp.clipsToBounds = true
        img_dp.layer.masksToBounds = true
        img_dp.contentMode = .scaleAspectFill
        
        img_dp.layer.borderWidth = 2.0
        img_dp.layer.borderColor = UIColor.white.cgColor
    }

    private func setupTableView() {
        self.tbl_view.register(UINib(nibName: "acc_TB", bundle: nil), forCellReuseIdentifier: "acc_TB")
        self.tbl_view.delegate = self
        self.tbl_view.dataSource = self
    }

    func fetchUserData() {
        guard let documentID = uid else {
            print("UID is nil")
            return
        }
        
        db.collection("user").document(documentID).getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            print("Document data: \(String(describing: document.data()))")

            
            let data = document.data()
            let name = data?["name"] as? String ?? "No Name"
            self?.lbl_name.text = name
            
            if let photoURLString = data?["photoURL"] as? String, let photoURL = URL(string: photoURLString) {
                            // Use Kingfisher to load and cache the image
                            self?.img_dp.kf.setImage(with: photoURL, placeholder: UIImage(named: "Image 6"), options: [.transition(.fade(0.2))])
                        }
                }
    }

    @IBAction func act_log(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "log_VC") as? log_VC {
            vc.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func loadProfileImage() {
        if let uid = self.uid {
            let filename = getDocumentsDirectory().appendingPathComponent("user_Profile_img_\(uid)")
            if let data = try? Data(contentsOf: filename) {
                img_dp.image = UIImage(data: data)
            }
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

extension profile_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "acc_TB") as? acc_TB else {
            fatalError("Failed to dequeue cell with identifier acc_TB")
        }
        
        cell.img_icon.image = self.imgArr[indexPath.row]
        cell.lbl_nm.text = self.titleArr[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)

        if indexPath.row == 0 {
            if let vc = storyboard.instantiateViewController(withIdentifier: "edit_VC") as? edit_VC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if indexPath.row == 1 {
            if let vc = storyboard.instantiateViewController(withIdentifier: "order_VC") as? order_VC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

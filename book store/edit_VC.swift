//
//  edit_VC.swift
//  book store
//
//  Created by Apple 6 on 13/06/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class edit_VC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var img_add: UIImageView!
    @IBOutlet weak var dp_dob: UITextField!
    
  
            
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /* let button = UIButton(type: .roundedRect)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
      
        let txtfield = UITextField()
       txtfield.layer.cornerRadius = 10
        txtfield.clipsToBounds = true*/
        
        
        let imgwidth = img_add.frame.size.width
        img_add.layer.cornerRadius = imgwidth / 2
        img_add.clipsToBounds = true
        img_add.layer.masksToBounds = true
        img_add.contentMode = .scaleAspectFill
        
        img_add.layer.borderWidth = 2.0
        img_add.layer.borderColor = UIColor.white.cgColor
        
        //UIDatePicker dp_dob = [UIDatePicker.autoContentAccessingProxy()].self
//dp_dob.inputView = dp_dob;
        
        img_add.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(imgtapped))
        img_add.addGestureRecognizer(tapgesture)
        
        self.dp_dob.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
   
    
    @objc func tapDone(){
        if let datepicker = self.dp_dob.inputView as? UIDatePicker{
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.dp_dob.text = dateformatter.string(from: datepicker.date)
            
            
        }
        self.dp_dob.resignFirstResponder()
        
        
}
    @IBAction func act_cancel(_ sender: UIButton) {
        self.TF_name.text=""
        self.TF_pass.text=""
        self.TF_email.text=""
        self.TF_phone.text=""
        self.dp_dob.text=""
        
         self.navigationController?.popViewController(animated: true)
    
         
    }
    
   
    
    
    
    @IBOutlet weak var TF_name: UITextField!
 
    
    
    @IBOutlet weak var TF_email: UITextField!
    
    
    @IBOutlet weak var TF_phone: UITextField!
    
    @IBOutlet weak var TF_pass: UITextField!
    
    
    @IBAction func act_save(_ sender: UIButton) {
        
     
        
        let username = self.TF_name.text!
        let email = self.TF_email.text!
        let phoneno = self.TF_phone.text!
        let password = self.TF_pass.text!
        let date = self.dp_dob.text!
        
        let data = [
            "Name": username,
            "Dob": date,
            "pass": password,
            "Email": email,
            "Number": phoneno
        
        
        ]
     //  updateFirestoreUserProfile(uid: user.uid, data: data)
        
        guard username.isEmpty == false &&
        email.isEmpty == false &&
        phoneno.isEmpty == false &&
        password.isEmpty == false &&
        date.isEmpty == false else{
            showAlert(title: "ERROR", message: "Please Fill The Entry")
            
                
            
       return
            
        }
      
        print(username.capitalizedSentence)
        
        if password.count < 6 {
            
            showAlert(title: "ERROR", message: "Password must be 6 characters long.")
            return
        }
        
       
        guard email.isValidEmail() == true else{
            showAlert(title: "ERROR", message: "Invalid Email")
            return
        }
        guard phoneno.isValidPhoneNumber(phoneno) else{
                        showAlert(title: " ERROR ", message: "Invalid Phoneno.")
                        return
                    }
        showAlert(title: "Saved", message: "Successfully saved information")
        self.navigationController?.popViewController(animated: true)
      
            
       
   
        
        
     /*  guard email.isValidEmail() == true else{
            showAlert(title: "ERROR", message: "Invalid Email ID")
            return
        }*/
    
        
 /* func validate(value: String) -> Bool {
    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
 let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result = phoneTest.evaluate(with: value)
            return result
          }
  */


}
    func showAlert(title: String, message:String){
        let missingInformationAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        missingInformationAlert.addAction(cancelAction)
        self.present(missingInformationAlert,animated: true,completion: nil)
        
    }
    
    

    
    @objc func imgtapped(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        
    }
    @objc  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let selectedimg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            img_add.image = selectedimg
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
         dismiss(animated: true, completion: nil)
     }
    
}

    //image func
  /*  @IBAction func openImagePicker(_ sender: UIButton) {
        presentImagePicker()
    }
    
    
    private func presentImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // Or .camera for capturing photos
        present(imagePicker, animated: true, completion: nil)
    }
  @objc  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
    
           
            img_add.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

   @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Handle the user canceling the image picker, if needed.
        dismiss(animated: true, completion: nil)
    }
   // extension edit_VC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{}
    
}*/







/*(import UIKit

class ImagePickerExampleViewController: UIViewController {
    let imagePicker = UIImagePickerController()
    // MARK: Outltes
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Properties
    let imagePicker = ImagePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    // Function to present the image picker when a button is tapped
    @IBAction func openImagePickerButtonTapped(_ sender: UIButton) {
        imagePicker.showImagePicker(from: self, allowsEditing: false)
    }
    
}

extension ImagePickerExampleViewController: ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        // Handle the selected image
        // You can display, upload, or process the image as needed
        imageView.image = image
    }
    
    func cancelButtonDidClick(on imagePicker: ImagePicker) {
        print("Image selection/capture was canceled")
    }*/
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

extension String {
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^\\d{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: phoneNumber)
    }
}

extension String {
    var capitalizedSentence: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
}

func updateFirestoreUserProfile(uid: String, data: [String:Any]) {
    Firestore.firestore().collection("users").document(uid).updateData(data) { err in
        if let err = err {
            print("Error updating document: \(err) ")
        }
        else {
            print("Document successfully updated")
        }
    }
}


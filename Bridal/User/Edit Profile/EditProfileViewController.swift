//
//  EditProfileViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 30/06/2021.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase


class EditProfileViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var imageURL = ""
    var imageChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DataServices.CurrentUserData.email == " "{
           if Auth.auth().currentUser?.uid != nil {
              DataServices.instance.getUserData(uId: (Auth.auth().currentUser?.uid)!) {[weak self](success)
                in
                if success {
                    self!.displayUserInfo()
                    }else {
                        print("no users")
                    }
                }
            }
        }else {
           displayUserInfo()
        }
    }
    func displayUserInfo(){
        let user = DataServices.CurrentUserData
        if user.email != " "{
           self.phoneTextField.text = user.phone
           self.firstNameTextField.text = user.firstName
           self.lastNameTextField.text = user.lastName
           self.emailTextField.text = user.email
           self.userImageView.image = user.image
        }
    }
    @IBAction func uploadNewPhotoClicked(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        loadingIndicator.startAnimating()
        if imageChanged {
            
           DataServices.instance.uploudPhotosToStoragen(images: [userImageView.image!]) {[weak self] imageURL, error in
                if error == "" {
                    self!.imageURL = imageURL[0]
                    self!.updatUserInfo(imageStringURL: self!.imageURL)
                }else {
                    print(error as Any)
                }
           }
        }else {
            self.updatUserInfo(imageStringURL: self.imageURL)
        }
        
    }
    
    func updatUserInfo(imageStringURL: String){
        let firstName = self.firstNameTextField.text!
        let lastName = self.lastNameTextField.text!
        let email = self.emailTextField.text!
        let mobile = self.phoneTextField.text!
        let userId =  Auth.auth().currentUser!.uid
        let image = imageStringURL
        
        let userData: [String: Any] = [
            "firstName" :firstName,
            "lastName" : lastName ,
            "email" : email,
            "mobile": mobile,
            "userId": userId,
            "image":image,
            "userPremium": "0"
         ]
        DataServices.CurrentUserData = User(firstName: firstName, lastName: lastName, uId: userId, email: email, imageStringURL: image, phone: mobile)
        
        DataServices.instance.createDBUser(uid: Auth.auth().currentUser!.uid, userData: userData)
        loadingIndicator.stopAnimating()
    
        let mainStoryboard = UIStoryboard(name: "HomeTabViewController", bundle: nil)
        guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "HomeTabViewController") as? HomeTabViewController  else {
            return
        }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}

extension EditProfileViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            userImageView.image = image
            imageChanged = true
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


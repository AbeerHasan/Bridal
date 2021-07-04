//
//  UserProfileViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 26/06/2021.
//

import UIKit
import Firebase


class SettingViewController: UIViewController {
    

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var languageSwitch: UISegmentedControl!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var allowNotificationSwitch: UISwitch!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DataServices.CurrentUserData.email == " "{
           if Auth.auth().currentUser?.uid != nil {
            loadingIndicator.startAnimating()
              DataServices.instance.getUserData(uId: (Auth.auth().currentUser?.uid)!) {[weak self](success)
                in
                if success {
                    self!.displayUserInfo()
                    self!.loadingIndicator.stopAnimating()
                    }else {
                        print("no users")
                        self!.loadingIndicator.stopAnimating()
                    }
                
                }
            }
        }
    }
    func displayUserInfo(){
        let user = DataServices.CurrentUserData
        if user.email != " "{
            if user.phone == "" || user.phone == " " {
                self.phoneLabel.isHidden = true
            }else {
                self.phoneLabel.isHidden = false
                self.phoneLabel.text = user.phone
            }
           self.userNameLabel.text = user.firstName + " " + user.lastName
           self.emailLabel.text = user.email
           self.userImageView.image = user.image
        }
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
        displayUserInfo()
      
    }
    
    @IBAction func backBottunClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func editProfileButtonClicked(_ sender: Any){
        let mainStoryboard = UIStoryboard(name: "EditProfileViewController", bundle: nil)
        guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "EditProfileViewController") as? EditProfileViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
             //First action
             let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTapped) in
                 
                     try! Auth.auth().signOut()
                DataServices.CurrentUserData = User(firstName: " ", lastName: " ", uId: " ", email: " ", imageStringURL: "", phone: "")
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "LogInViewController") as? LogInViewController else {
                        return
                    }
                    self.navigationController?.pushViewController(signUpVC, animated: true)
                 
             }
             logoutPopup.addAction(logoutAction)
             //second acction
             let cancel = UIAlertAction(title: "cancel", style: .destructive) { (buttonTapped) in
                self.dismiss(animated: true, completion: nil)
             }
             logoutPopup.addAction(cancel)
             present(logoutPopup, animated: true, completion: nil)
    }
    @IBAction func changeClicked(_ sender: Any) {
        
    }
    @IBAction func settingButtonClicked(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "SettingViewController", bundle: nil)
        guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}

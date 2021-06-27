//
//  UserProfileViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 26/06/2021.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var languageSwitch: UISegmentedControl!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var allowNotificationSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser?.uid != nil {
                    DataServices.instance.getUserData(uId: (Auth.auth().currentUser?.uid)!) { (name, email) in
                        self.userNameLabel.text = name
                        self.emailLabel.text = email
                    }
                }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
    }
    @IBAction func editProfileButtonClicked(_ sender: Any){
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
    }
    
}

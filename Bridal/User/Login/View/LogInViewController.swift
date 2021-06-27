//
//  ViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 25/06/2021.
//

import UIKit
import SkyFloatingLabelTextField
import FBSDKLoginKit
import FacebookCore
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var authErrorLabel: UILabel!
    var textFields = [SkyFloatingLabelTextField]()
    
    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields.append(emailTextField)
        textFields.append(passwordTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()

    }
 
    @IBAction func loginButtonClicked(_ sender: Any) {
        var allIsValied = true
        authErrorLabel.isHidden = true
        
        for text in textFields {
            text.errorMessage = ""
            
            if Validation.isFilledText(textField: text) {
                text.errorMessage = "Required Field!"
                allIsValied = false
            }else  {
                let error = Validation.isValideInput(textField: text)
                text.errorMessage = error
                if error != "" {
                  allIsValied = false
                }
            }
        }
        
        if allIsValied {
            AuthService.instance.loginUser(email: emailTextField.text!, password: passwordTextField.text!) { (success, loginError) in
                   if success {
                    print("Success")
                    let mainStoryboard = UIStoryboard(name: "HomeTabViewController", bundle: nil)
                    guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "HomeTabViewController") as? HomeTabViewController else {
                        return
                    }
                    self.navigationController?.pushViewController(signUpVC, animated: true)
                   }else {
                    self.authErrorLabel.text = "Wrong Email or Password"
                    self.authErrorLabel.isHidden = false
                   }
               }
        }
    }
    
    @IBAction func registerButtonClicked(_ sender: Any){
        let mainStoryboard = UIStoryboard(name: "SignUpViewController", bundle: nil)
        guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController  else {
            return
        }
        navigationController?.pushViewController(signUpVC, animated: true)
    
    }
    
    @IBAction func forgitPasswordButtonClicked(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "ForgetPasswordViewController", bundle: nil)
        guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "ForgetPasswordViewController") as? ForgetPasswordViewController  else {
            return
        }
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
    
    
    @IBAction func loginWithFacebookClicked(_ sender: Any) {
        loginManager.logIn(permissions: ["public_profile","email"], from: self) { [weak self] (res, error)
            in
            if((AccessToken.current) != nil){
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, password"]).start(completionHandler: { (connection, result, error) -> Void
                    in
                    if (error == nil){
                       /* let info = result as! NSDictionary
                        AuthService.instance.registerUser(firstName: info.value(forKey: "first_name") as! String, lastName: info.value(forKey: "last_name") as! String, email: info.value(forKey: "email") as! String, password:info.value(forKey: "password") as! String) {
                            [weak self](success, error) in
                            if success {
                                
                            }
                        }*/
                    }
                })
            }
            
        }
    }
    @IBAction func loginWithGoogleKlicked(_ sender: Any) {
    }
}


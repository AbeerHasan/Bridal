//
//  ViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 25/06/2021.
//

import UIKit
import SkyFloatingLabelTextField
import FBSDKCoreKit
import FacebookCore
import FacebookLogin
import FirebaseAuth
import MOLH
import Firebase


class LogInViewController: UIViewController{

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
   
    @IBOutlet weak var authErrorLabel: UILabel!
    var textFields = [SkyFloatingLabelTextField]()
    
    @IBOutlet weak var englishLanguageButton: UIButton!
    @IBOutlet weak var arabicLanguageButton: UIButton!
    
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIButton()
        let image = UIImage(systemName: "eye.fill")
        imageView.setImage(image, for: .normal)
        imageView.addTarget(self, action: #selector(show_hide_Text), for: .touchUpInside)
        passwordTextField.rightView = imageView
        passwordTextField.rightViewMode = .always
        if Auth.auth().currentUser != nil {
            let mainStoryboard = UIStoryboard(name: "HomeTabViewController", bundle: nil)
            guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "HomeTabViewController") as? HomeTabViewController else {
                return
            }
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
        textFields.append(emailTextField)
        textFields.append(passwordTextField)
    }
    @objc func show_hide_Text(){
        let imageView = UIButton()
        let image = UIImage(systemName: "eye.slash.fill")
        imageView.setImage(image, for: .normal)
        imageView.addTarget(self, action: #selector(show_hide_Text), for: .touchUpInside)
        passwordTextField.rightView = imageView
        passwordTextField.rightViewMode = .always
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
        
        if MOLHLanguage.currentAppleLanguage() == "ar" {
            arabicLanguageButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            arabicLanguageButton.shadowOpacity = 1
            englishLanguageButton.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.5921568627, blue: 0.01568627451, alpha: 1)
            englishLanguageButton.shadowOpacity = 0
        }else {
            arabicLanguageButton.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.5921568627, blue: 0.01568627451, alpha: 1)
            arabicLanguageButton.shadowOpacity = 0
            englishLanguageButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            englishLanguageButton.shadowOpacity = 1

        }
    }
    
    @IBAction func changeLanguageButtonClicked(_ sender: Any) {
        /*MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")*/
        MOLH.setLanguageTo( "ar" )
        MOLH.reset(transition: .transitionCrossDissolve)
    }
    @IBAction func changeToEnglish(_ sender: Any) {
        MOLH.setLanguageTo( "en" )
        MOLH.reset(transition: .transitionCrossDissolve)
        
    }
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
       
        var allIsValied = true
        authErrorLabel.isHidden = true
        
        for text in textFields {
            text.errorMessage = ""
            
            if Validation.isFilledText(textField: text) {
                text.errorMessage = "Required Field!"
                allIsValied = false
            }
        }
        let error = Validation.isValideInput(textField: emailTextField)
        if  error != ""{
            emailTextField.errorMessage = error
            allIsValied = false
        }
        
        if allIsValied {
            loadingIndicator.startAnimating()
            
            AuthService.instance.loginUser(email: emailTextField.text!, password: passwordTextField.text!) {[weak self] (success, loginError) in
                   if success {
                      self!.loadingIndicator.stopAnimating()
                    
                      let mainStoryboard = UIStoryboard(name: "HomeTabViewController", bundle: nil)
                      guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "HomeTabViewController") as? HomeTabViewController else {
                        return
                      }
                      self!.navigationController?.pushViewController(signUpVC, animated: true)
                  }else {
                      self!.authErrorLabel.text = "Wrong Email or Password"
                      self!.authErrorLabel.isHidden = false
                    
                      self!.loadingIndicator.stopAnimating()
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
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void
                            in
                            if (error == nil){
                            Auth.auth().signIn(with: credential) {[weak self] authResult, error in
                                if error == nil {
                                   let user = authResult?.user
                                   let userData: [String: Any] = [
                                    "firstName" : user?.displayName as Any,
                                    "lastName" : " " ,
                                    "email" : user!.email!,
                                    "mobile": user!.phoneNumber ?? " ",
                                    "userId": user!.uid ,
                                    "image": user!.photoURL?.absoluteString as Any,
                                    "userPremium": "0"
                                    ]
                                    
                                    DataServices.instance.createDBUser(uid: user!.uid, userData: userData)
                                     let mainStoryboard = UIStoryboard(name: "HomeTabViewController", bundle: nil)
                                     guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "HomeTabViewController") as? HomeTabViewController else {
                                         return
                                     }
                                     self?.navigationController?.pushViewController(signUpVC, animated: true)
                            }
                        }
                      
                    }else {
                        self?.authErrorLabel.text = error?.localizedDescription
                    }
                })
            }
        }
    }
        
    @IBAction func loginWithGoogleKlicked(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "HomeTabViewController", bundle: nil)
        guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "HomeTabViewController") as? HomeTabViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}


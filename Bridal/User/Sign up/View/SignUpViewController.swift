//
//  SignUpViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 25/06/2021.
//

import UIKit
import SkyFloatingLabelTextField

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var confirPasswordTextField: SkyFloatingLabelTextField!
    
    var textFields = [SkyFloatingLabelTextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields.append(emailTextField)
        textFields.append(passwordTextField)
        textFields.append(firstNameTextField)
        textFields.append(lastNameTextField)
        textFields.append(confirPasswordTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
    }
    @IBAction func registerButtonClicked(_ sender: Any) {
        var allIsValied = true
        
        for text in textFields {
            text.errorMessage = ""
            
            if Validation.isFilledText(textField: text) {
                text.errorMessage = "Required Field!"
                allIsValied = false
            }else  {
                if text.placeholder == " Confirm Password" && passwordTextField.errorMessage == "" {
                    let isValid = Validation.checkPasswordConfirmation(password: passwordTextField.text!, confirmation: confirPasswordTextField.text!)
                    if !isValid {
                        confirPasswordTextField.errorMessage = "Doesn't match password"
                        allIsValied = false
                    }
                }else {
                    let error = Validation.isValideInput(textField: text)
                    text.errorMessage = error
                    if error != "" {
                      allIsValied = false
                    }
                }
            }
        }
        
        if allIsValied {
            AuthService.instance.registerUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!) { (success, registerError) in
                   if success {
                    
                    let mainStoryboard = UIStoryboard(name: "HomeTabViewController", bundle: nil)
                    guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "HomeTabViewController") as? HomeTabViewController else {
                        return
                    }
                    self.navigationController?.pushViewController(signUpVC, animated: true)
                   }else {
                       print(String(registerError!.localizedDescription))
                   }
               }
        }
    }
    
}

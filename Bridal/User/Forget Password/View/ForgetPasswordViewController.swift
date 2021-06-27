//
//  ForgetPasswordViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 27/06/2021.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

class ForgetPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    @IBAction func goButtonClicked(_ sender: Any) {
        if emailTextField.text != "" && emailTextField.text != " " {
            let error = Validation.isValideInput(textField: emailTextField)
            emailTextField.errorMessage = error
        }else {
            emailTextField.errorMessage = "Requered Field!"
        }
        if emailTextField.errorMessage == "" {
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) {[weak self] (error) in
                if let error = error {
                    let PopUp = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    self!.present(PopUp, animated: true, completion: nil)
                    return
                }
                let PopUp = UIAlertController(title: "Email sent", message: "Please check your email", preferredStyle: .alert)
                self!.present(PopUp, animated: true, completion: nil)
                let chooseCommunityAction = UIAlertAction(title: "Ok", style: .destructive) { (buttonTapped) in
                               do {
                                self!.navigationController?.popViewController(animated: true)
                               }
                           }
                PopUp.addAction(chooseCommunityAction)
                
            }
        }
    }
    

 

}

//
//  FieldValidation.swift
//  Bridal
//
//  Created by Abeer Hasan on 26/06/2021.
//

import UIKit
import FirebaseAuth

enum Regex :String {
       case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       case password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
       case phone = "(0)+([0-9]{10})"
       case names = "^[a-zA-Z]*$"
   
   }

class Validation {
    static func isFilledText(textField: UITextField) -> Bool{
        if textField.text == "" || textField.text == " " {
            return true
        }
        return false
    }
    
    static func isValideInput(textField: UITextField) -> String {
        if textField.placeholder!.contains("Password") {
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", Regex.password.rawValue)
            if !passwordTest.evaluate(with: textField.text) {
                return "Not valid Password"//"Your Password should 8 chars with numbers, lower and upper case chars!"
            }
        }else if textField.placeholder!.contains("Email") {
            let emailTest = NSPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
            if !emailTest.evaluate(with: textField.text) {
                return "Not a valid Email!"
            }
        }else if textField.placeholder!.contains("Name") {
            let nameTest = NSPredicate(format: "SELF MATCHES %@", Regex.names.rawValue)
            if !nameTest.evaluate(with: textField.text) {
                return "Name can be only chars!"
            }
        }
        
        return ""
    }
    
    static func checkPasswordConfirmation(password: String, confirmation: String) -> Bool{
        if password == confirmation {
            return true
        }
        return false
    }
}


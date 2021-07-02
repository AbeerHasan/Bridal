//
//  UIViewControllerExtension.swift
//  Bridal
//
//  Created by Abeer Hasan on 26/06/2021.
//

import UIKit
let languageKey = "ChangeLanguage"

struct AppNotification {
    static let changLanguage = Notification.Name("changLanguage")
}
extension UIViewController {
    
    func hideNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
       // navigationController?.hidesBarsOnSwipe = true
       // navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.1894885978, green: 0.1894885978, blue: 0.1894885978, alpha: 1)
    }
    
    func alert (){
        let alert = UIAlertController(title: "", message: "Change_Language", preferredStyle: .alert)
        let actionArabic = UIAlertAction(title: "LANG-AR", style: .default) { action in
            UserDefaults.standard.set("ar",forKey: languageKey)
            NotificationCenter.default.post(name: AppNotification.changLanguage, object: nil)
            
        }
        let actionEnglish = UIAlertAction(title: "LANG-EN", style: .default) { action in
            UserDefaults.standard.set("en",forKey: languageKey)
            NotificationCenter.default.post(name: AppNotification.changLanguage, object: nil)
            
        }
        alert.addAction(actionArabic)
        alert.addAction(actionEnglish)
        
        present(alert, animated: true)
    }
}

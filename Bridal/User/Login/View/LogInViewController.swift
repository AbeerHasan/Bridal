//
//  ViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 25/06/2021.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerButtonClicked(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController  else {
            return
        }
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}


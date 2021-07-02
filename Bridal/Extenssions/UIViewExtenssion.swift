//
//  UIViewExtenssion.swift
//  Bridal
//
//  Created by Abeer Hasan on 26/06/2021.
//

import UIKit
@IBDesignable

extension UIView {
    @IBInspectable var cornerRadius : CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
  
    @IBInspectable var shadowOpacity : CGFloat {
        set {
            self.layer.shadowOpacity = Float(newValue)
            setUpView()
        }
        get {
            return CGFloat(self.layer.shadowOpacity)
        }
    }

    //----------------------------------------------
    func setUpView(){
        let sceenWidth = UIScreen.main.bounds.width
        if sceenWidth >= 568 {
            self.layer.cornerRadius = cornerRadius * 2.5
        }else {
            self.layer.cornerRadius = cornerRadius
        }
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 1.7
        
    }
    
}

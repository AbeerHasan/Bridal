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
  
}

//
//  UILabelExtension.swift
//  Bridal
//
//  Created by Abeer Hasan on 01/07/2021.
//

import Foundation
import UIKit
import MOLH

@IBDesignable

extension UILabel {
    
    @IBInspectable var localizationKey : String {
        set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
        get {
            return self.localizationKey
        }
    }
}
extension UITextField {
    @IBInspectable var localizationKey : String {
        set {
            self.placeholder = NSLocalizedString(newValue, comment: "")
        }
        get {
            return self.localizationKey
        }
    }
}

extension UIButton {
    @IBInspectable var localizationKey : String {
        set {
            self.setTitle(NSLocalizedString(newValue, comment: ""), for: .normal)
        }
        get {
            return self.localizationKey
        }
    }
}

//
//  User.swift
//  Bridal
//
//  Created by Abeer Hasan on 26/06/2021.
//

import UIKit

struct User: Codable
{
    private var _userId  : String
    private var _firstName : String
    private var _lastName : String
    private var _email : String
    private var _phone : String?
    private var _imageStringURL : String?
    
    var firstName : String {
        return _firstName
    }
    var lastName : String {
        return _lastName
    }
    var userId : String {
        return _userId
    }
    var email : String {
        return _email
    }
    var phone : String? {
        return _phone ?? ""
    }
    var imageStringURL : String? {
        return _imageStringURL ?? ""
    }
    var image : UIImage? {
        if imageStringURL != nil {
           let _picURL = URL(string: imageStringURL! )
           if _picURL != nil {
            let _imageData = NSData(contentsOf: _picURL!)!
            let image = UIImage(data: _imageData as Data)
            
            return image
            }
        }
        return UIImage.init(systemName: "person.crop.square")
   
    }
        
    init(firstName: String, lastName: String, uId: String, email: String, imageStringURL: String, phone: String?) {
        self._firstName = firstName
        self._userId = uId
        self._email = email
        self._imageStringURL = imageStringURL
        self._lastName = lastName
        self._phone = phone
    }
}

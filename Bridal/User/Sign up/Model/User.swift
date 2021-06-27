//
//  User.swift
//  Bridal
//
//  Created by Abeer Hasan on 26/06/2021.
//

import UIKit

class User {
    private var _userId  : String
    private var _firstName : String
    private var _lastName : String
    private var _email : String
    private var _image : UIImage
    
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
    var image : UIImage {
        return _image
    }
    
    init(firstName: String, lastName: String, uId: String, email: String, image: UIImage) {
        self._firstName = firstName
        self._userId = uId
        self._email = email
        self._image = image
        self._lastName = lastName
    }
}

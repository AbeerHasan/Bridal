//
//  DataServices.swift
//  Bridal
//
//  Created by Abeer Hasan on 26/06/2021.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class DataServices {
    static let instance = DataServices()
   
    static var CurrentUserData = User(firstName: " ", lastName: " ", uId: " ", email: " ", imageStringURL: "", phone: "")
    static var selectedCategory : Category?
    static var selectedProduct : Product?

    private var _REF_BASE = FIREBASE_BASE_URL
    private var _REF_USERS = FIREBASE_BASE_URL.child("users")
    private var _REF_CATEGORY = FIREBASE_BASE_URL.child("Category")
     var _REF_PRODUCT = FIREBASE_BASE_URL.child("product")
   
    var REF_BASE :DatabaseReference {
        return _REF_BASE
    }
    var REF_USERS :DatabaseReference {
        return _REF_USERS
    }
   
    //---------------------------------------------------------
    func createDBUser(uid: String , userData: Dictionary<String , Any>){
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
    func getUserData(uId: String , handler: @escaping (_ success: Bool) -> ()){
        REF_USERS.observeSingleEvent(of: .value) { (usersSnapShot) in
            guard let usersSnapShot = usersSnapShot.children.allObjects as? [DataSnapshot] else {return}
            for user in usersSnapShot {
                if user.key == uId {
                    let firstName = user.childSnapshot(forPath: "firstName").value as! String
                    let lastName = user.childSnapshot(forPath: "lastName").value as! String
                    
                    var  imageStringURL = ""
                    if user.childSnapshot(forPath: "image").exists() {
                        imageStringURL = user.childSnapshot(forPath: "image").value as! String
                    }
                    
                    var  phone = ""
                    if user.childSnapshot(forPath: "mobile").exists() {
                       phone = user.childSnapshot(forPath: "mobile").value as! String
                    }
                    let email = user.childSnapshot(forPath: "email").value as! String
                    DataServices.CurrentUserData = User(firstName: firstName, lastName: lastName, uId: uId, email: email, imageStringURL: imageStringURL, phone: phone)
                    handler(true)
                }
            }
        }
    }
    
    func getProducts(by key: String , value: String,completion: @escaping (_ products: [Product]) -> ()){
        var products = [Product]()
        _REF_PRODUCT.observeSingleEvent(of: .value) { (productsSnapShot) in
            guard let productsSnapShot = productsSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for product in productsSnapShot {
                let categoryName = product.childSnapshot(forPath: key).value as! String
                if categoryName == value {
                    let productID = product.key
                    let title = product.childSnapshot(forPath: "productTitle").value as! String
                    let supTitle = product.childSnapshot(forPath: "productDescription").value as! String
                    let price = product.childSnapshot(forPath: "productPrice").value as! String
                    let userId = product.childSnapshot(forPath: "userId").value as! String
                    let userName = product.childSnapshot(forPath: "userName").value as! String
                    let categoryName = product.childSnapshot(forPath: "categoryName").value as! String
                    let image1 = product.childSnapshot(forPath: "productImageOne").value as! String
                    let image2 = product.childSnapshot(forPath: "productImageTow").value as! String
                    let image3 = product.childSnapshot(forPath: "productImageThree").value as! String
                    var video = ""
                    if  product.childSnapshot(forPath: "video").exists()  {
                        video = product.childSnapshot(forPath: "video").value as! String
                    }
                    var imagesURL = [String]()
                    let images = [UIImage]()
                    
                    imagesURL.append(image1)
                    imagesURL.append(image2)
                    imagesURL.append(image3)
                   
                    
                    
                    var product = Product(categoryName: categoryName, supTitle: supTitle, price: price, title: title, userId: userId, images: images, video: video, userName: userName, productID: productID, imagesStringURL: imagesURL)
                    products.append(product)
                    completion(products)
                }
                
            }
          
        }
    }
    func uploudPhotosToStoragen(images: [UIImage],completion: @escaping (_ images:[String],_ error:String?) -> ()){
        var imagesURL = [String]()
        let storage =  Storage.storage().reference()
        
        for image in images {
            if let imageData = image.pngData() {
                storage.child("Photo/\(image.description).png").putData(imageData, metadata: nil) {_ , error in
                    guard error == nil else {
                        completion(imagesURL, error!.localizedDescription)
                        return
                    }
                    storage.child("Photo/\(image.description).png").downloadURL { (url, error) in
                    guard let url = url , error == nil else {
                        completion(imagesURL, error!.localizedDescription)
                        return
                    }
                    
                    let urlString = url.absoluteString
                    imagesURL.append(urlString)
                    completion(imagesURL,"")
                }
             }
            
          }
       }
    }
    func addProductTo(product: Product, completion: @escaping (_ success: Bool,_ error: String?) -> ()){
        uploudPhotosToStoragen(images: product.images) { [weak self] (images, error) in
            if error == "" && images.count == 3{
                self!._REF_PRODUCT.childByAutoId().updateChildValues([ "categoryName" : product.categoryName,
                                                                      "latitude" : "",
                                                                      "longitude" : "",
                                                                      "productDescription" : product.supTitle,
                                                                      "productImageOne" : images[0],
                                                                      "productImageThree" :images[1],
                                                                      "productImageTow" :images[2],
                                                                      "productPrice" : product.price,
                                                                      "productTitle" : product.title,
                                                                      "userId" : product.userId,
                                                                      "userName" : product.userName,
                                                                      "video" : product.video]
                                                                     )
             completion(true,"")
            }else {
                completion(false, error)
            }
        }
    }
    
    func deleteProduct(Id: String){
        _REF_PRODUCT.child(Id).removeValue()
    }
    
}


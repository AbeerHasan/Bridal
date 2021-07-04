//
//  AddProductViewController.swift
//  Bridal
//
//  Created by Abeer Hasan on 28/06/2021.
//

import UIKit
import iOSDropDown
import Firebase
import AVKit


class AddProductViewController: UIViewController {

    @IBOutlet weak var selectCategoryMenu: DropDown!
    @IBOutlet weak var productTitleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var firstImageButton: UIButton!
    @IBOutlet weak var secondImageButton: UIButton!
    @IBOutlet weak var thirdImageButton: UIButton!
    
    @IBOutlet weak var uploadVideoButton: UIButton!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var image1clicked = false
    var image2clicked = false
    var image3clicked = false
    var videoClicked = false
    var videoURLData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCategoryMenu.optionArray = ["Beauty Center", "Buffet Services","Car Rental", "Cosmetic Dentistry", "Domestic Flights", "Flowers","Health and Beauty", "Honey Moon", "Hotels", "Watches and Accessories", "Wedding Group", "DJ Services", "Wedding Suits","Wedding Dresses", "Wedding Halls","Gold and Gewelry"]
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addFirstImage(_ sender: Any) {
        image1clicked = true
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    @IBAction func addSecondImage(_ sender: Any) {
        image2clicked = true
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    @IBAction func addThirdImage(_ sender: Any) {
        image3clicked = true
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func uploadVideo(_ sender: Any) {
        videoClicked = true
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.mediaTypes = ["public.movie"]
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func addLocation(_ sender: Any) {
    }
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionArabic = UIAlertAction(title: "OK", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
            
        }
        alert.addAction(actionArabic)
        
        present(alert, animated: true)
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        var isFull = true
        
        if selectCategoryMenu.text == "Select Category" || selectCategoryMenu.text == "" || selectCategoryMenu.text == " "  {
            showErrorAlert(message: "Please select Category")
            isFull = false
        }else if  productTitleTextField.text == "" || productTitleTextField.text == " " || priceTextField.text == "" || priceTextField.text == " " || descriptionTextField.text == "" || descriptionTextField.text == " " {
            showErrorAlert(message: "Please fill the missing fields")
            isFull = false
        }else if firstImageButton.image(for: .normal) == nil || secondImageButton.image(for: .normal) == nil || thirdImageButton.image(for: .normal) == nil {
            showErrorAlert(message: "Please at three Photos for your product")
            isFull = false
        }
        
        if isFull {
        loadingIndicator.startAnimating()
        if uploadVideoButton.backgroundImage(for: .normal) == UIImage(systemName: "checkmark.rectangle") {
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "video/quicktime"
        let uniqueID = UUID().uuidString
        let ref = "Video/ProductVideo" + uniqueID
        Storage.storage().reference().child(ref).putData(videoURLData, metadata: uploadMetadata) {[weak self] (metaData, error) in
            if error != nil {
                print(error as Any)
                return
            }
            Storage.storage().reference().child(ref).downloadURL(completion: {[weak self] url, error in
                    let `self` = self!
                    if let url = url?.absoluteString {
                        self.uploadProduct(url: url)
                        self.loadingIndicator.stopAnimating()
                    }else {
                        print(error as Any)
                        self.loadingIndicator.stopAnimating()
                    }
                })
        }
        }else {
            uploadProduct(url: "")
            
        }
        }
    }
    
    func uploadProduct(url: String?){
        DataServices.instance.addProductTo(product: Product(categoryName: self.selectCategoryMenu.text!, supTitle: self.descriptionTextField.text! , price: self.priceTextField.text!, title: self.productTitleTextField.text!, userId: Auth.auth().currentUser!.uid , images: [self.firstImageButton.image(for: .normal)!,self.secondImageButton.image(for: .normal)!,self.thirdImageButton.image(for: .normal)!], video: url ?? "", userName: DataServices.CurrentUserData.firstName + " " + DataServices.CurrentUserData.lastName, productID: " ", imagesStringURL: [String]())) { [weak self] (success, error) in
            if success {
                self!.loadingIndicator.stopAnimating()
                let mainStoryboard = UIStoryboard(name: "HomeTabViewController", bundle: nil)
                guard let signUpVC = mainStoryboard.instantiateViewController(identifier: "HomeTabViewController") as? HomeTabViewController else {
                    return
                }
                self?.navigationController?.pushViewController(signUpVC, animated: true)
            }else {
                print(error ?? "Error")
                self!.loadingIndicator.stopAnimating()
            }
        }
    }
    
}

extension AddProductViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if videoClicked {
            guard let mediaType = info[.mediaType] as? String, mediaType == "public.movie", let movieURL = info[.mediaURL] as? URL else {
                  dismiss(animated: true)
                  return
              }
            
            uploadVideoButton.setImage(UIImage(), for: .normal)
            uploadVideoButton.setBackgroundImage(UIImage.init(systemName: "checkmark.rectangle"), for: .normal)
            //convert video to Data
            let videoData = try! Data(contentsOf: movieURL)
            videoURLData = videoData
            
            videoClicked = false
        }else {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            if image1clicked {
                firstImageButton.setImage(image, for: .normal)
                image1clicked = false
            }else if image2clicked {
                secondImageButton.setImage(image, for: .normal)
                image2clicked = false
            }else if image3clicked {
                thirdImageButton.setImage(image, for: .normal)
                image2clicked = false
            }
        }
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

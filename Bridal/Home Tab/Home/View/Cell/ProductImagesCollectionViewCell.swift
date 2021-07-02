//
//  ProductImagesCollectionViewCell.swift
//  Bridal
//
//  Created by Abeer Hasan on 28/06/2021.
//

import UIKit

class ProductImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    func setImage(image: UIImage){
        productImageView.image = image
    }
}

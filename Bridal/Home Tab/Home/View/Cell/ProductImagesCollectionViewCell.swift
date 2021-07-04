//
//  ProductImagesCollectionViewCell.swift
//  Bridal
//
//  Created by Abeer Hasan on 28/06/2021.
//

import UIKit
import Kingfisher

class ProductImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    func setImage(index: Int){
        let url = URL(string: DataServices.selectedProduct!.imagesStringURL[index])
        productImageView.kf.setImage(with: url)
    }
}

//
//  ProductsTableViewCell.swift
//  Bridal
//
//  Created by Abeer Hasan on 28/06/2021.
//

import UIKit
import Kingfisher

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var supTitleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
   
    
    func configurCell(product: Product){
        if product.images != nil {
            let url = URL(string: product.imagesStringURL[0])
            productImageView.kf.setImage(with: url)
        }else {
            productImageView.image = product.images[0]
        }
        titleLabel.text = product.title
        priceLabel.text = product.price
        supTitleLabel.text = product.supTitle
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

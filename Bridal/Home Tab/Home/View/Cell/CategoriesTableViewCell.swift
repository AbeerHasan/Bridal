//
//  TableViewCell.swift
//  Bridal
//
//  Created by Abeer Hasan on 27/06/2021.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var supTitleLabel: UILabel!
    
    func configurCell(category: Category){
        categoryImageView.image = category.image
        titleLabel.text = category.title
        supTitleLabel.text = category.supTitle
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
